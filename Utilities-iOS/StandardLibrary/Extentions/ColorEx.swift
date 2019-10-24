//  Created by SinaMN75 on 10/24/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import SwiftUI

extension UIColor {
    
    // MARK:- Converts Hex color to RGBA color.
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let hexColor = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
            
            if hexColor.count == 8 {
                var hexNumber: UInt64 = 0
                
                if Scanner(string: hexColor).scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    
    // MARK:- Creates a Random color.
    func random() -> UIColor {
        return UIColor(red:   .random(in: 0...255),
                       green: .random(in: 0...255),
                       blue:  .random(in: 0...255),
                       alpha: 1.0)
    }
}

@available(iOS 13.0, *)
extension Color {
    
    // MARK:- Converts Hex color to RGBA color.
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }
        
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }
        
        if string.count > 8 {
            string = String(string.prefix(8))
        }
        
        let scanner = Scanner(string: string)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        if string.count == 2 {
            let mask = 0xFF
            let g = Int(color) & mask
            let gray = Double(g) / 255.0
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        } else if string.count == 4 {
            let mask = 0x00FF
            let g = Int(color >> 8) & mask
            let a = Int(color) & mask
            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}
