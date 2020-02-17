//  Created by SinaMN75 on 9/28/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import PDFKit

class PdfReaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var collectionViewPages: UICollectionView!
    @IBOutlet weak var collectionViewPdf: UICollectionView!
    
    private var pageList = [UIImage]()
    private var pdfList = pdf()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewPages.delegate = self
        collectionViewPages.dataSource = self
        collectionViewPdf.delegate = self
        collectionViewPdf.dataSource = self
        
        pdfView.usePageViewController(true)
        
        
        //        pdfDocument = PDFDocument(url: url1!)
        //        pdfView.document = pdfDocument
        //        pdfView.usePageViewController(true)
        
        
//        showThumbnales(pdfDocument: pdfDocument!)
        
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
            cellPdf.labelTitle.text = pdfList[indexPath.row].title
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
        case collectionViewPdf:
            pdfList[indexPath.row].currentPage = (pdfView.currentPage?.pageRef!.pageNumber)! - 1
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionViewPdf:
            pdfView.document = pdfList[indexPath.row].pdf
            if let page = pdfList[indexPath.row].pdf!.page(at:pdfList[indexPath.row].currentPage!) { pdfView.go(to: page) }
            
            
            showThumbnales(pdfDocument: pdfList[indexPath.row].pdf!)
            collectionViewPages.reloadData()
            
        default: break
        }
    }
}

class PdfPageCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

class PdfListCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonCloseAction: UIButton!
}

struct PDF {
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
    
    if let url3 = URL(string: "https://www.pdfpdf.com/samples/Sample3.PDF") {
        pdfList.append(PDF.init(id: "ccc", title: "PDF 3", currentPage: 0, pdfDocument: PDFDocument(url: url3)!))
    }
    
    return pdfList
}
