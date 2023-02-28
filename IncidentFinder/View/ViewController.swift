//
//  ViewController.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Type

    typealias Section = IncidentViewModel.Section
    typealias Item = IncidentViewModel.Item

    // MARK: - properties

    var viewModel: IncidentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        viewModel.getIncidents()
    }

}

private extension ViewController {
    
    func configureViewModel() {
        viewModel = IncidentViewModel(incidentService: IncidentService(parser: IncidentParser()))
    }
    
}
