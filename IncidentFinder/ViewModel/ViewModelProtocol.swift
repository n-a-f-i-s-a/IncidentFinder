//
//  ViewModelProtocol.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
}
