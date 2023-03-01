//
//  ViewController.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit

final class IncidentViewController: UIViewController {
    
    // MARK: - Type

    typealias Section = IncidentViewModel.Section
    typealias Item = IncidentViewModel.Item

    // MARK: - properties

    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: IncidentViewModel!
    
    private lazy var dataSource = configureDataSource()
    private var incidentService: IncidentServiceProtocol {
        if ProcessInfo.processInfo.arguments.contains("Testing") {
            return MockIncidentService()
        }
        return IncidentService(parser: IncidentParser())
    }
    private var isSortedDescending: Bool = true
    private var storyBoardName: String = "Main"
    private var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureNavBar()
        configureRefreshControl()
        configureCollectionView()
        
        getIncidents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavTitle(prefersLargeTitles: true, title: viewModel.title)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        configureNavTitle(prefersLargeTitles: false, title: "")
    }
    
}

private extension IncidentViewController {
    
    func configureViewModel() {
        viewModel = IncidentViewModel(incidentService: incidentService)
    }
    
    func configureNavTitle(prefersLargeTitles: Bool, title: String) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: viewModel.imageName),
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
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(
                refreshIncidentData),
                for: .valueChanged
         )
        refreshControl.tintColor = .spinnerColor
    }
    
    @objc func refreshIncidentData() {
        getIncidents()
    }
    
    func configureCollectionView() {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.collectionViewLayout = listLayout
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        collectionView.refreshControl = refreshControl
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
            
            if refreshControl.isRefreshing {
                self.activityIndicatorView.stopAnimating()
            } else {
                self.activityIndicatorView.startAnimating()
            }
            
            self.collectionView.isUserInteractionEnabled = false
        case .empty:
            self.activityIndicatorView.stopAnimating()
            self.collectionView.isUserInteractionEnabled = true
            self.update(with: viewModel.incidents, animate: false)
            self.refreshControl.endRefreshing()
        case .loaded:
            self.collectionView.isUserInteractionEnabled = true
            self.update(with: viewModel.incidents, animate: false)
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
        case .idle:
            break
        case .error(let error):
            self.collectionView.isUserInteractionEnabled = true
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
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

        if viewModel.state == .empty {
            snapshot.appendItems([IncidentViewModel.Item.empty("Oops! We didn't find any incident. Sorry! Please try again.")], toSection: .empty)
        }

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
                                imageURL: item.typeIcon,
                                imageCache: viewModel.imageCache
                            )
                        )
                    }
                    
                    return cell
                case .empty:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier,
                        for: indexPath) as? EmptyCollectionViewCell else { fatalError("Could not create new cell") }

                    if case let .empty(item) = incidentItem {
                        cell.configure(
                            emptyCellViewModel: EmptytCellViewModel(title: item)
                        )
                    }
                    
                    return cell
                }
                
            }
        )
    }
    
}

// MARK: - delegate

extension IncidentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = DetailViewController.instantiateFromStoryboard(storyboardName: storyBoardName)

        if case let .detail(viewModel) = viewModel.selectItem(row: indexPath.row){
            nextViewController.viewModel = viewModel
        }

        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
