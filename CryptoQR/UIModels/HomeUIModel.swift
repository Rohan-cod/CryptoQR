//
//  HomeUIModel.swift
//  CryptoQR
//
//  Created by Rohan  Gupta on 19/10/22.
//

import SwiftUI

struct HomeUIModel {
    let title: String
    let titleForegroundColor: Color
    let titleFont: Font
    
    let resultForegroundColor: Color
    let resultFont: Font

    let scanButtonLabel: String
    let scanButtonForegroundColor: Color
    let scanButtonBackgroundColor: Color

    var isValid: Bool
    var validationResultColor: Color {
        if isValid {
            return .green
        } else {
            return .red
        }
    }
    var validationResultText: String {
        if isValid {
            return "Valid"
        } else {
            return "Invalid"
        }
    }

    var addressType: String?
    var addressTypeDescription: String? {
        if let addressType = addressType {
            return "The address is a \(addressType) address"
        } else {
            return nil
        }
    }

    let cornerRadius: CGFloat
}
