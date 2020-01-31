//  Created by SinaMN75 on 10/24/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import SwiftUI

extension UIColor {
    
    convenience init(hex: String) {
         let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
         var int = UInt64()
         Scanner(string: hex).scanHexInt64(&int)
         let a, r, g, b: UInt64
         switch hex.count {
         case 3: // RGB (12-bit)
             (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
         case 6: // RGB (24-bit)
             (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
         case 8: // ARGB (32-bit)
             (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
         default:
             (a, r, g, b) = (255, 0, 0, 0)
         }
         self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
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
        if string.hasPrefix("#") { _ = string.removeFirst() }
        
        if !string.count.isMultiple(of: 2), let last = string.last { string.append(last) }
        
        if string.count > 8 { string = String(string.prefix(8))}
        
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
