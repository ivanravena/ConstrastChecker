//
//  CheckColors.swift
//  ConstrastChecker
//
//  Created by Ivan Ravena Pinheiro Ribeiro on 17/01/25.
//

// This file contains the main color variables (foreground and background) as ObservableObjects.

// ObservableObject is a protocol that allows a class to work with SwiftUI's state management system
// @Published is a property wrapper that automatically notifies SwiftUI when the value changes


import SwiftUI

// Possible accessibility levels

enum AccessibilityLevel {
    case fail
    case aa
    case aaa
    
    var display: String {
        switch self {
        case .fail: return "FAIL"
        case .aa: return "AA"
        case .aaa: return "AAA"
        }
    }
}

// Structure to hold contrast check results

struct ContrastResult {
    let ratio: Double
    let normalText: AccessibilityLevel
    let largeText: AccessibilityLevel
    let graphics: AccessibilityLevel
}

class CheckColors: ObservableObject {
    
    // @Published tells Swift to update the UI when the colors change.
    
    @Published var foregroundColor: Color = .gray
    @Published var backgroundColor: Color = .black
    
    // Swap colors action
    
    func swapColors() {
        let temp = foregroundColor
        foregroundColor = backgroundColor
        backgroundColor = temp
    }
    
    // Calculate the relative luminance of a color
        private func relativeLuminance(for color: Color) -> Double {
            // Convert Color to UIColor to get RGB components
            let uiColor = UIColor(color)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            // Convert to sRGB
            let rsRGB = red <= 0.03928 ? red/12.92 : pow((red + 0.055)/1.055, 2.4)
            let gsRGB = green <= 0.03928 ? green/12.92 : pow((green + 0.055)/1.055, 2.4)
            let bsRGB = blue <= 0.03928 ? blue/12.92 : pow((blue + 0.055)/1.055, 2.4)
            
            // Calculate luminance
            return 0.2126 * rsRGB + 0.7152 * gsRGB + 0.0722 * bsRGB
        }
        
        // Calculate contrast ratio
        func calculateContrastRatio() -> ContrastResult {
            let l1 = relativeLuminance(for: foregroundColor)
            let l2 = relativeLuminance(for: backgroundColor)
            
            // Calculate contrast ratio according to WCAG formula
            let lighter = max(l1, l2)
            let darker = min(l1, l2)
            let ratio = (lighter + 0.05) / (darker + 0.05)
            
            // Determine accessibility levels
            let normalText: AccessibilityLevel = {
                if ratio >= 7 { return .aaa }
                if ratio >= 4.5 { return .aa  }
                return .fail
            }()
            
            let largeText: AccessibilityLevel = {
                if ratio >= 4.5 { return .aaa }
                if ratio >= 3 { return .aa }
                return .fail
            }()
            
            let graphics: AccessibilityLevel = {
                if ratio >= 3 { return .aa }
                return .fail
            }()
            
            return ContrastResult(
                ratio: ratio,
                normalText: normalText,
                largeText: largeText,
                graphics: graphics
            )
        }
}

