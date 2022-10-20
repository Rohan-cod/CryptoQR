//
//  ScannerViewModel.swift
//  CryptoQR
//
//  Created by Rohan  Gupta on 19/10/22.
//

import SwiftUI

// Enum for BTC address types
enum CodeType {
    case legacy
    case p2sh
    case segwit
    case taproot
    
    var description: String {
        switch self {
        case .legacy: return "Legacy Adresses (P2PKH)"
        case .p2sh: return "Pay to Script Hash (P2SH)"
        case .segwit: return "Native SegWit (P2WPKH)"
        case .taproot: return "Taproot (P2TR)"
        }
    }

    var prefix: String {
        switch self {
        case .legacy: return "1"
        case .p2sh: return "3"
        case .segwit: return "bc1q"
        case .taproot: return "bc1p"
        }
    }
}


class ScannerViewModel: ObservableObject {
    @Published var scannedCode: String?
    @Published var isValid: Bool?
    @Published var codeType: CodeType?
    private let addressRegex: String = "^([13]|bc1q|bc1p)[a-zA-Z0-9]{27,34}$"

    // UI Model for the home screen
    @Published var homeUIModel: HomeUIModel = HomeUIModel(
        title: "QR Code Scanner", titleForegroundColor: .orange, titleFont: .headline,
        resultForegroundColor: .purple, resultFont: .system(size: 14, weight: .bold),
        scanButtonLabel: "Scan a QR Code", scanButtonForegroundColor: .blue,
        scanButtonBackgroundColor: .gray.opacity(0.5), isValid: false, cornerRadius: 8)
    
    // Function to Validate BTC Address
    func validateCode(_ code: String) -> Bool {
        if code.matches(addressRegex) {
            isValid = true
        } else {
            isValid = false
        }

        homeUIModel.isValid = isValid!

        return isValid!
    }
    
    // Function to get type of address
    func getAddressType(_ code: String) -> CodeType? {
        if code.hasPrefix(CodeType.legacy.prefix) {
            codeType = .legacy
        } else if code.hasPrefix(CodeType.p2sh.prefix) {
            codeType = .p2sh
        } else if code.hasPrefix(CodeType.segwit.prefix) {
            codeType = .segwit
        } else if code.hasPrefix(CodeType.taproot.prefix) {
            codeType = .taproot
        } else {
            codeType = nil
        }

        homeUIModel.addressType = codeType?.description

        return codeType
    }
    
    // Function to process scanned code
    func processScannedCode(_ code: String?) {
        if let code = code {
            scannedCode = code
            _ = validateCode(code)
            _ = getAddressType(code)
        }
    }
}
