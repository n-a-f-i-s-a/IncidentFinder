//
//  DetailCellViewModel.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation

final class TextCellViewModel {
    
    // MARK: - properties
    
    var title: String
    var subtitle: String
    
    init(
        title: String,
        subtitle: String
    ) {
        self.title = title
        self.subtitle = subtitle
    }
    
}
