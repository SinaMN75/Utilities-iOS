//  Created by SinaMN75 on 9/28/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import PDFKit

class PdfReaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PdfCellDelegate {
        
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var collectionViewPages: UICollectionView!
    @IBOutlet weak var collectionViewPdf: UICollectionView!
    @IBOutlet weak var collectionViewOutline: UICollectionView!
    
    private var pageList = [UIImage]()
    private var pdfList = pdf()
    private var selectedPdfIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewPages.delegate = self
        collectionViewPages.dataSource = self
        collectionViewPdf.delegate = self
        collectionViewPdf.dataSource = self
        pdfView.usePageViewController(true)
        
    }
    
    private func showThumbnales(pdfDocument: PDFDocument) {
        pageList.removeAll()
        for i in 0...pdfDocument.pageCount - 1 {
            pageList.append((pdfDocument.page(at: i)?.thumbnail(of: CGSize(width: 100, height: 130), for: .artBox))!)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewPdf: return pdfList.count
        case collectionViewPages: return pageList.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionViewPdf:
            let cellPdf = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPdf", for: indexPath) as! PdfListCell
            cellPdf.setupPdfs(pdf: pdfList[indexPath.row])
            cellPdf.delegate = self
            return cellPdf
        case collectionViewPages:
            let cellPdfPage = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPdfPage", for: indexPath) as! PdfPageCell
            cellPdfPage.imageView.image = pageList[indexPath.row]
            return cellPdfPage
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionViewPdf: pdfList[indexPath.row].currentPage = (pdfView.currentPage?.pageRef!.pageNumber)! - 1
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionViewPdf:
            pdfView.document = pdfList[indexPath.row].pdf
            if let page = pdfList[indexPath.row].pdf!.page(at:pdfList[indexPath.row].currentPage!) { pdfView.go(to: page) }
            selectedPdfIndex = indexPath.row
            
//            showThumbnales(pdfDocument: pdfList[indexPath.row].pdf!)
//            collectionViewPages.reloadData()
            
        case collectionViewPages: if let page = pdfView.document?.page(at:indexPath.row) { pdfView.go(to: page) }
        default: break
        }
    }
    
    func onCloseTapped(pdf: PDF) {
        if pdfList.count == 1 {
            
        } else {
            let index = pdfList.remove(object: pdf)
            collectionViewPdf.reloadData()
            
            if index != -1 && index == selectedPdfIndex {
                if index == 0 {
                    pdfView.document = pdfList[index].pdf
                    if let page = pdfList[index].pdf!.page(at:pdfList[index].currentPage!) { pdfView.go(to: page) }
                    selectedPdfIndex = index
                } else {
                    pdfView.document = pdfList[index - 1].pdf
                    if let page = pdfList[index - 1].pdf!.page(at:pdfList[index - 1].currentPage!) { pdfView.go(to: page) }
                    selectedPdfIndex = index - 1
                }
            }
        }
    }
    
    func saveData() {
        do {
            let jsonData = try JSONEncoder().encode(pdff())
            let jsonString = String(data: jsonData, encoding: .utf8)!
            set(value: jsonString, key: "pdf")
            print(jsonString)
                        
            let s = getString(key: "pdf")
            
            print(try! JSONDecoder().decode([PdfModel].self, from: Data(s!.utf8)).first?.pdfTitle! as Any)
            
        } catch { print(error) }
    }


}

struct PDF: Equatable {
    var id: String?
    var title: String?
    var currentPage: Int?
    var pdf: PDFDocument?
    
    init(id: String, title: String, currentPage: Int, pdfDocument: PDFDocument) {
        self.id = id
        self.title = title
        self.currentPage = currentPage
        self.pdf = pdfDocument
    }
}

func pdf() -> [PDF] {
    var pdfList = [PDF]()
    
    if let url1 = URL(string: "https://www.pdfpdf.com/samples/Sample1.PDF") {
        pdfList.append(PDF.init(id: "aaa", title: "PDF 1", currentPage: 0, pdfDocument: PDFDocument(url: url1)!))
    }

    if let url2 = URL(string: "https://www.pdfpdf.com/samples/Sample2.PDF") {
        pdfList.append(PDF.init(id: "bbb", title: "PDF 2", currentPage: 0, pdfDocument: PDFDocument(url: url2)!))
    }

    if let url3 = URL(string: "https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf") {
        pdfList.append(PDF.init(id: "ccc", title: "PDF 3", currentPage: 0, pdfDocument: PDFDocument(url: url3)!))
    }
    
    return pdfList
}

func pdff() -> [PdfModel] {
    var pdf = [PdfModel]()
    
    pdf.append(PdfModel(pdfTitle: "hello", pdfPath: "path...."))
    pdf.append(PdfModel(pdfTitle: "hi", pdfPath: "directory...."))
    return pdf
}

protocol PdfCellDelegate {
    func onCloseTapped(pdf: PDF)
}

class PdfListCell: UICollectionViewCell {
    
    var pdf: PDF!
    var delegate: PdfCellDelegate!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    
    @IBAction func buttonCloseAction(_ sender: Any) { delegate.onCloseTapped(pdf: pdf) }
    
    func setupPdfs(pdf: PDF) {
        self.pdf = pdf
        labelTitle.text = pdf.title
    }
}

struct PdfModel: Codable {
    var pdfTitle: String!
    var pdfPath: String!
    var pdfOpenPage: Int!
    
    init(pdfTitle: String, pdfPath: String, pdfOpenPage: Int = 0) {
        self.pdfTitle = pdfTitle
        self.pdfPath = pdfPath
        self.pdfOpenPage = pdfOpenPage
    }
}

class PdfPageCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

class PdfOutlineCell: UICollectionViewCell {
    @IBOutlet weak var buttonOutlineTitle: UIButton!
    @IBOutlet weak var buttonOutlineTitleAction: UIButton!
}
