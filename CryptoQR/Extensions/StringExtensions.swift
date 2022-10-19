//
//  StringExtensions.swift
//  CryptoQR
//
//  Created by Rohan  Gupta on 19/10/22.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
