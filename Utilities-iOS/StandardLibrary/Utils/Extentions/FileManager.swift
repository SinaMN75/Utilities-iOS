

import Foundation

class FilesManager:NSObject{
    static let `default` = FilesManager()
    
    private let manager = FileManager.default
    
    public func path(_ name: String)->URL?{
        return manager.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("Files").appendingPathComponent(name)
    }
    
    public func getFilesInDirectory(_ name: String)->[String]?{
        return autoreleasepool{()->[String]? in
            let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
            if manager.fileExists(atPath: path.path){
                return try? manager.contentsOfDirectory(atPath: path.path)
            }else{
                createDirectory("Files")
                return try? manager.contentsOfDirectory(atPath: path.path)
            }
        }
    }
    
    public func clearAll(_ name: String){
        autoreleasepool{
            let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
            let content = try? manager.contentsOfDirectory(atPath: path.path)
            for p in content ?? [] {
                let fullPath = path.appendingPathComponent(p)
                try? manager.removeItem(at: fullPath)
            }
        }
    }
    
    public func deleteManual(_ dName: String, _ mName: String){
        autoreleasepool{
            let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent(dName)
            try? manager.removeItem(at: path.appendingPathComponent(mName))
        }
    }
    
    public func createDirectory(_ name: String){
        autoreleasepool{
            let path = manager.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name)")
            if !manager.fileExists(atPath: path!.path){
                try? manager.createDirectory(atPath: path!.path, withIntermediateDirectories: true, attributes: nil)
            }
        }
    }
    
    public func isDirectory(_ path: String)->Bool{
        let comp = path.components(separatedBy: ".")
        if comp.count > 1{
            return false
        }
        return true
    }
    
    public func isDirectory(_ path: URL)->Bool{
        let comp = path.absoluteString.components(separatedBy: ".")
        if comp.count > 1{
            return false
        }
        return true
    }
    
}
