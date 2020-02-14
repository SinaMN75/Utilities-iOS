//  Created by SinaMN75 on 2/13/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

class DownloadManagerViewController: UIViewController, MZDownloadManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mzDownloadManager(delegate: self).addDownloadTask("1", fileURL: SAMPLE_10_VIDEO, destinationPath: "\(MZUtility.baseFilePath)/My Downloads", fileId: 1)
    }
    
    func downloadRequestDidUpdateProgress(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestDidPopulatedInterruptedTasks(_ downloadModel: [MZDownloadModel]) { }
    
    func downloadRequestStarted(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestCanceled(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestDidRetry(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestFinished(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestDidPaused(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestDidResumed(_ downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestDidFailedWithError(_ error: NSError, downloadModel: MZDownloadModel, index: Int) { }
    
    func downloadRequestDestinationDoestNotExists(_ downloadModel: MZDownloadModel, index: Int, location: URL) { }
}
