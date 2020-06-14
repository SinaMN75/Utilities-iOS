//  Created by SinaMN75 on 9/28/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import PDFKit

class PdfReaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MZDownloadManagerDelegate {
    func downloadRequestDidUpdateProgress(_ downloadModel: MZDownloadModel, index: Int) {
        print(downloadModel.fileName ?? "")
        print(downloadModel.progress)
    }
    
    func downloadRequestDidPopulatedInterruptedTasks(_ downloadModel: [MZDownloadModel]) { }
    
    func downloadRequestFinished(_ downloadModel: MZDownloadModel, index: Int) {
        print("Finished: " + downloadModel.fileName)
        print("Finished: " + downloadModel.destinationPath)
        
        let pdf = PdfModel(pdfTitle: downloadModel.fileName, pdfPath: "downloadModel.destinationPath/\(downloadModel.fileName!).pdf")
        
        pdfList.append(pdf)
    }
    
    
    var pdf: PdfModel!
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var collectionViewPages: UICollectionView!
    @IBOutlet weak var collectionViewPdf: UICollectionView!
    @IBOutlet weak var buttonOpenOutlines: UIButton!
    @IBOutlet weak var widthCons: NSLayoutConstraint!
    
    private var pdfList = [PdfModel]()
    private var selectedPdfIndex = 0
    private var isOutlinesOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadManager(delegate: self).addDownloadTask("p1", fileURL: "https://www.pdfpdf.com/samples/Sample1.PDF",
                                                        destinationPath: "\(MZUtility.baseFilePath)/My Downloads", fileId: 1)
        
//        get()
//        collectionViewPdf.delegate = self
//        collectionViewPdf.dataSource = self
//        pdfView.usePageViewController(true)
        
        
    }
    
    private func get() {
        do {
            pdfList = try JSONDecoder().decode([PdfModel].self, from: Data(getString(key: "pdf")!.utf8))
            pdfList.append(pdf)
        } catch { print(error) }
    }
    
    func saveData() {
        do { set(value: String(data: try JSONEncoder().encode(pdfList), encoding: .utf8)!, key: "pdf") }
        catch { print(error) }
    }
    
    @IBAction func buttonOpennOutlinesAction(_ sender: Any) {
        if !isOutlinesOpen {
            self.widthCons.constant = 250
            isOutlinesOpen = true
        }
        else {
            self.widthCons.constant = 0
            isOutlinesOpen = false
        }
        UIView.animate(withDuration: 0.8) { self.view.layoutIfNeeded() }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return pdfList.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPdf", for: indexPath) as! PdfListCell
        c.labelTitle.text = pdfList[indexPath.row].pdfTitle
        c.close = { self.onCloseTapped(pdf: self.pdfList[indexPath.row]) }
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        pdfList[indexPath.row].pdfOpenPage = (pdfView.currentPage?.pageRef!.pageNumber)! - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = FilesManager.default.path(pdfList[indexPath.row].pdfPath) else { return }
        let pdfDocument = PDFDocument(url: url)
        pdfView.document = pdfDocument
        if let page = pdfDocument?.page(at: pdfList[indexPath.row].pdfOpenPage) { pdfView.go(to: page) }
        selectedPdfIndex = indexPath.row
    }
    
    func onCloseTapped(pdf: PdfModel) {
        if pdfList.count == 1 { self.dismiss() }
        else {
            let index = pdfList.remove(object: pdf)
            collectionViewPdf.reloadData()
            if index != -1 && index == selectedPdfIndex {
                if index == 0 {
                    guard let url = FilesManager.default.path(pdf.pdfPath) else { return }
                    let pdfDocument = PDFDocument.init(url: url)
                    pdfView.document = pdfDocument
                    if let page = pdfDocument?.page(at:pdfList[index].pdfOpenPage!) { pdfView.go(to: page) }
                    selectedPdfIndex = index
                } else {
                    guard let url = FilesManager.default.path(pdfList[index - 1].pdfPath!) else { return }
                    let document = PDFDocument.init(url: url)
                    pdfView.document = document
                    if let page = document?.page(at:pdfList[index - 1].pdfOpenPage) { pdfView.go(to: page) }
                    selectedPdfIndex = index - 1
                }
            }
        }
    }
}

class PdfListCell: UICollectionViewCell {
    var close: (()->Void)?
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBAction func buttonCloseAction(_ sender: Any) { close?() }
}

struct PdfModel: Codable, Equatable {
    var pdfTitle: String!
    var pdfPath: String!
    var pdfOpenPage: Int!
    
    init(pdfTitle: String, pdfPath: String, pdfOpenPage: Int = 0) {
        self.pdfTitle = pdfTitle
        self.pdfPath = pdfPath
        self.pdfOpenPage = pdfOpenPage
    }
}
