//
//  CurrencyUtil.swift
//  OpenMarket
//
//  Created by Cristhian Tolosa on 2024-01-24.
//

import Foundation

class CurrencyUtil {

    static func getCurrencyNumber(balance: String, fractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        let number = Double(balance) ?? 0.0
        let formattedNumber = formatter.string(from: NSNumber(value: number))
        return "$ " + (formattedNumber ?? "0.0")
    }

    static func getCleanValue(value: String) -> Int {
        var cleanValue: String = value
        if (cleanValue.contains("$")) {
            cleanValue = cleanValue.replacingOccurrences(of: "$", with: "")
        }

        if (cleanValue.contains(" ")) {
            cleanValue = cleanValue.replacingOccurrences(of: " ", with: "")
        }

        if (cleanValue.contains(".")) {
            cleanValue = cleanValue.replacingOccurrences(of: ".", with: "")
        }

        return Int(cleanValue) ?? 0
    }
}
