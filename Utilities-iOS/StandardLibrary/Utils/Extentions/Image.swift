//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import Photos
import ImageIO

extension UIImageView {
    
    func loadGif(name: String) {DispatchQueue.global().async { DispatchQueue.main.async { self.image = UIImage.gif(name: name) } } }
    
    func loadGif(asset: String) { DispatchQueue.global().async { DispatchQueue.main.async { self.image = UIImage.gif(asset: asset) } } }
}

func makeImage(_ image: String) -> UIImage { return UIImage(named: image)?.withRenderingMode(.alwaysOriginal) ?? UIImage() }

extension PHAsset {
    func toUIImage() -> UIImage {
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        PHImageManager.default().requestImage(for: self,
                                              targetSize: CGSize(width: 100, height: 100),
                                              contentMode: .aspectFit, options: option,
                                              resultHandler: {(result, info)->Void in thumbnail = result!
        })
        return thumbnail
    }
}

// MARK- Gif

extension UIImage {
    class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }
    class func gif(url: String) -> UIImage? {
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        return gif(data: imageData)
    }
    class func gif(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        return gif(data: imageData)
    }
    class func gif(asset: String) -> UIImage? {
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        return gif(data: dataAsset.data)
    }
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer { gifPropertiesPointer.deallocate() }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false { return delay }
        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        var delayObject: AnyObject =
            unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        if let delayObject = delayObject as? Double, delayObject > 0 { delay = delayObject }
        else { delay = 0.1 }
        return delay
    }
    class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        if rhs == nil || lhs == nil {
            if rhs != nil { return rhs! }
            else if lhs != nil { return lhs! }
            else { return 0 }
        }
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }
        var rest: Int
        while true {
            rest = lhs! % rhs!
            if rest == 0 { return rhs! }
            else {
                lhs = rhs
                rhs = rest
            }
        }
    }
    class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty { return 1 }
        var gcd = array[0]
        for val in array { gcd = UIImage.gcdForPair(val, gcd) }
        return gcd
    }
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        for index in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) { images.append(image) }
            delays.append(Int(UIImage.delayForImageAtIndex(Int(index), source: source) * 1000.0)) // Seconds to ms
        }
        let duration: Int = {
            var sum = 0
            for val: Int in delays { sum += val }
            return sum
        }()
        var frames = [UIImage]()
        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcdForArray(delays))
            for _ in 0..<frameCount { frames.append(frame) }
        }
        return UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
    }
}
