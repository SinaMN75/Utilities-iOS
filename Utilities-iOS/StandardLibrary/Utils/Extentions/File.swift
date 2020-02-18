//  Created by SinaMN75 on 2/17/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import Foundation

fileprivate let manager = FileManager.default


func createDirectory(_ name: String){
    autoreleasepool {
        let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name)")
        if !manager.fileExists(atPath: path!.path){
            try? manager.createDirectory(atPath: path!.path, withIntermediateDirectories: true, attributes: nil)
        }
    }
}

func getFilesInDirectory(_ name: String)->[String]?{
    return autoreleasepool{()->[String]? in
        let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
        if manager.fileExists(atPath: path.path){
            return try? manager.contentsOfDirectory(atPath: path.path)
        }else{
            createDirectory("DownloadedFiles")
            return try? manager.contentsOfDirectory(atPath: path.path)
        }
    }
}

func clearAll(_ name: String){
    autoreleasepool{
        let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
        let content = try? manager.contentsOfDirectory(atPath: path.path)
        for p in content ?? [] {
            let fullPath = path.appendingPathComponent(p)
            try? manager.removeItem(at: fullPath)
        }
    }
}

func isDirectory(_ path: String) -> Bool{
    let comp = path.components(separatedBy: ".")
    if comp.count > 1 { return false }
    return true
}

func isDirectory(_ path: URL) -> Bool{
    let comp = path.absoluteString.components(separatedBy: ".")
    if comp.count > 1 { return false }
    return true
}
