//
//  Colors.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

extension UIColor {
    
    static func makeBadgeColor(status: Incident.StatusType) -> UIColor {
        switch status {
        case .onScene:
            return .systemBlue
        case .outOfControl:
            return .systemRed
        case .pending:
            return .systemOrange
        case .underControl:
            return .systemGreen
        }
    }
    
    static var secondaryFontColor: UIColor {
        .systemGray5
    }
    
    static var barButtonColor: UIColor {
        .systemGray
    }
    
    static var spinnerColor: UIColor {
        .systemBlue
    }
    
}
