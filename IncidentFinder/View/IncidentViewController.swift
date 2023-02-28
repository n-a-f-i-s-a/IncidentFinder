//
//  ViewController.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

class IncidentViewController: UIViewController {
    
    // MARK: - Type

    typealias Section = IncidentViewModel.Section
    typealias Item = IncidentViewModel.Item

    // MARK: - properties

    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: IncidentViewModel!
    
    private lazy var dataSource = configureDataSource()
    private var incidentService = IncidentService(parser: IncidentParser())
    private var isSortedDescending: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureViewModel()
        configureCollectionView()
        
        getIncidents()
    }
    
}

private extension IncidentViewController {
    
    func configureViewModel() {
        viewModel = IncidentViewModel(incidentService: incidentService)
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Incidents"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.and.down.square"),
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
    }
    
    @objc func addTapped(sender: UIButton) {
        isSortedDescending.toggle()
        viewModel.sortIncidents(isDescending: isSortedDescending)
        self.update(with: viewModel.incidents, animate: false)
    }
    
    func configureCollectionView() {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.collectionViewLayout = listLayout
        
        collectionView.dataSource = dataSource
        
       
    }
    
    func getIncidents() {
        viewModel.state = .loading
        
        Task { [weak self] in
            do {
                viewModel.incidents = []
                viewModel.state = .loading
                self?.evaluateState()
                try await viewModel.fetchIncidents()
                self?.evaluateState()
            } catch {
                self?.evaluateState()
            }
        }
    }
    
    func evaluateState() {
        switch viewModel.state {
        case .loading:
            self.update(with: viewModel.incidents, animate: false)
            self.activityIndicatorView.startAnimating()
            self.collectionView.isUserInteractionEnabled = false
        case .empty:
            self.activityIndicatorView.stopAnimating()
            self.collectionView.isUserInteractionEnabled = true
            self.update(with: viewModel.incidents, animate: false)
        case .loaded:
            self.collectionView.isUserInteractionEnabled = true
            self.update(with: viewModel.incidents, animate: false)
            self.activityIndicatorView.stopAnimating()
        case .idle:
            break
        case .error(let error):
            self.collectionView.isUserInteractionEnabled = true
            self.activityIndicatorView.stopAnimating()
            showError(error)
        }
    }
    
}

// MARK: - datsource

private extension IncidentViewController {
    
    func update(with incidents: [Incident], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)

        let allIncidentItems = incidents.map { IncidentViewModel.Item.incident($0)}
        snapshot.appendItems(allIncidentItems, toSection: .basicInfo)

        

        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        return UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { [unowned self] collectionView, indexPath, incidentItem in
                
                let sectionType = Section.allCases[indexPath.section]
                
                switch sectionType {
                case .basicInfo:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: IncidentCollectionViewCell.reuseIdentifier,
                        for: indexPath) as? IncidentCollectionViewCell else { fatalError("Could not create new cell") }

                    if case let .incident(item) = incidentItem {
                        cell.configure(
                            incidentCellViewModel: IncidentCellViewModel(
                                incidentService: self.incidentService,
                                lastUpdated: item.lastUpdated,
                                title: item.title,
                                status: item.status,
                                imageURL: item.typeIcon
                            )
                        )
                    }
                    
                    return cell
                case .empty:
                    // To implement
                    return nil
                }
                
            }
        )
    }
    
}
