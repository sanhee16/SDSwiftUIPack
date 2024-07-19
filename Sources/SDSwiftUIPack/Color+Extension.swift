//
//  File.swift
//  
//
//  Created by Sandy on 7/19/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex string: String, opacity: CGFloat? = nil) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }
        
        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }
        
        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }
        
        // Scanner creation
        let scanner = Scanner(string: string)
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        if string.count == 2 {
            let mask = 0xFF
            let g = Int(color) & mask
            let gray = Double(g) / 255.0
            
            
            if let opacity = opacity {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: opacity)
            } else {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
            }
        } else if string.count == 4 {
            let mask = 0x00FF
            
            let g = Int(color >> 8) & mask
            let a = Int(color) & mask
            
            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0
            
            if let opacity = opacity {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: opacity)
            } else {
                self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
            }
        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            
            if let opacity = opacity {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
            } else {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
            }
            
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
            
            if let opacity = opacity {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
            } else {
                self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
            }
            
        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
    
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
