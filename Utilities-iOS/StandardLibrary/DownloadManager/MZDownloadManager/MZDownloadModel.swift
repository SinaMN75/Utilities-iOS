//  Created by SinaMN75 on 2/13/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

public enum TaskStatus: Int {
    case unknown, gettingInfo, downloading, paused, failed
    
    public func description() -> String {
        switch self {
        case .gettingInfo: return "GettingInfo"
        case .downloading: return "Downloading"
        case .paused: return "Paused"
        case .failed: return "Failed"
        default: return "Unknown"
        }
    }
}

open class MZDownloadModel: NSObject {
    open var fileId: Int?
    open var fileName: String!
    open var fileURL: String!
    open var status: String = TaskStatus.gettingInfo.description()
    open var file: (size: Float, unit: String)?
    open var downloadedFile: (size: Float, unit: String)?
    open var remainingTime: (hours: Int, minutes: Int, seconds: Int)?
    open var speed: (speed: Float, unit: String)?
    open var progress: Float = 0
    open var task: URLSessionDownloadTask?
    open var startTime: Date?
    
    fileprivate(set) open var destinationPath: String = ""
    
    fileprivate convenience init(fileName: String, fileURL: String, fileId: Int) {
        self.init()
        self.fileName = fileName
        self.fileURL = fileURL
        self.fileId = fileId
    }
    
    convenience init(fileName: String, fileURL: String, destinationPath: String, fileId: Int) {
        self.init(fileName: fileName, fileURL: fileURL, fileId: fileId)
        self.destinationPath = destinationPath
    }
}
