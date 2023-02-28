//
//  DetailViewController.swift
//  IncidentFinder
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController, ViewModelProtocol {
    
    // MARK: - Type

    typealias Section = DetailViewModel.Section
    typealias Item = DetailViewModel.Item
    
    // MARK: - Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: DetailViewModel!
    
    private lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureNavBar()
        update(with: [viewModel.incident])
    }
    
    func configureCollectionView() {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.collectionViewLayout = listLayout
        
        collectionView.dataSource = dataSource
    }
    
    func configureNavBar() {
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: viewModel.imageName),
            style: .plain,
            target: self,
            action: #selector(navigate)
        )
    }
    
    @objc func navigate() {
        let coordinates = viewModel.location
        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
        mapItem.name = viewModel.title
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ])
    }
    
}

private extension DetailViewController {
    
    func update(with incidents: [Incident], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        
        let mapItem = incidents.map { DetailViewModel.Item.map($0)}
        snapshot.appendItems(mapItem, toSection: .info)
        
        let locationItem = incidents.map { DetailViewModel.Item.location($0.location)}
        snapshot.appendItems(locationItem, toSection: .info)
        
        let statusItem = incidents.map { DetailViewModel.Item.status($0.status.rawValue)}
        snapshot.appendItems(statusItem, toSection: .info)
        
        let typeItem = incidents.map { DetailViewModel.Item.type($0.type)}
        snapshot.appendItems(typeItem, toSection: .info)
        
        let callTimeItem = incidents.map { DetailViewModel.Item.callTime(Formatter.formattedDateString(date: $0.callTime))}
        snapshot.appendItems(callTimeItem, toSection: .info)
        
        let descriptionItem = incidents.compactMap {
            if let description = $0.description {
                return DetailViewModel.Item.description(description)
            }
            return nil
        }
        
        snapshot.appendItems(descriptionItem, toSection: .info)
        
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        return UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { [unowned self] collectionView, indexPath, incidentItem in
                
                switch incidentItem {
                case .map(let item):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: MapCollectionViewCell.reuseIdentifier,
                        for: indexPath) as? MapCollectionViewCell else { fatalError("Could not create new cell") }
                    cell.configure(
                        mapCellViewModel: MapCellViewModel(
                            incidentAnnotation: IncidentAnnotation(
                                title: item.title,
                                locationName: item.location,
                                coordinate: CLLocationCoordinate2D.init(
                                    latitude: item.latitude,
                                    longitude: item.longitude),
                                image: viewModel.imageCache.getCachedImage(urlString: item.typeIcon.absoluteString as NSString)
                            )
                        )
                    )
                    return cell
                case .location, .status, .type, .callTime, .description:
                    return self.makeTextCell(
                        title: incidentItem.title,
                        subtitle: incidentItem.subtitle,
                        indexPath: indexPath
                    )
                }
            }
        )
    }
    
    func makeTextCell(
        title: String,
        subtitle: String,
        indexPath: IndexPath
    ) -> TextCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TextCollectionViewCell.reuseIdentifier,
             for: indexPath) as? TextCollectionViewCell else { fatalError("Could not create new cell") }

        cell.configure(
            textCellViewModel: TextCellViewModel(
                title: title,
                subtitle: subtitle
            )
        )
        
        return cell
    }
    
}
