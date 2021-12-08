//
//  DoubleExtension.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toFixedString(_ places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
