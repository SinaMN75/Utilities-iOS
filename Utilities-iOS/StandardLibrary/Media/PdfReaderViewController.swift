//  Created by SinaMN75 on 9/28/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import PDFKit

class PdfReaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var collectionViewPages: UICollectionView!
    
    private var list = [UIImage]()
    private var pdfDocument: PDFDocument!
    private let url = URL(string: "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewPages.delegate = self
        collectionViewPages.dataSource = self
        
        pdfDocument = PDFDocument(url: url!)
        pdfView.document = pdfDocument
        pdfView.usePageViewController(true)
        showThumbnales(pdfDocument: pdfDocument!)
    }
    
    private func showThumbnales(pdfDocument: PDFDocument) {
        let pageCount = pdfDocument.pageCount
        for i in 0...pageCount - 1 {
            list.append((pdfDocument.page(at: i)?.thumbnail(of: CGSize(width: 100, height: 130), for: .artBox))!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath) as! CollectionViewCellPdfReaderVC
        cell.imageView.image = list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pdfView.go(to: pdfDocument.page(at: indexPath.row)!)
    }
}

class CollectionViewCellPdfReaderVC : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}
