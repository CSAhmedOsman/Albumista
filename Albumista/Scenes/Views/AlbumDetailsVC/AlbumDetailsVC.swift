//
//  AlbumDetailsVC.swift
//  Albumista
//
//  Created by Mac on 15/12/2024.
//

import UIKit
import Combine

class AlbumDetailsVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!

    weak var coordinator: AppCoordinating?
    private var viewModel: AlbumDetailsViewModel

    private var collectionViewHandler: CollectionViewHandler<PhotoModel, PhotoCollectionViewCell>!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: AlbumDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationItem()
        setupCollectionViewHandler()
        setupUI()
        viewModel.fetchPhotos()
    }

    private func setupUI() {
        searchBarPublisher().sink { [weak self] value in
            self?.viewModel.searchAlbums(with: value)
        }.store(in: &cancellables)
        
        viewModel.$photos.sink { [weak self] items in
            self?.collectionViewHandler.didItemsChanged(with: items)
        }.store(in: &cancellables)
        
        viewModel.$errorMessage.sink { [weak self] errorMessage in
            if let errorMessage {
                self?.showErrorAlert(bodyMessage: errorMessage)
            }
        }.store(in: &cancellables)
    }
    
    private func searchBarPublisher() -> AnyPublisher<String, NotificationCenter.Publisher.Failure> {
        return NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
            .compactMap { ($0.object as? UISearchTextField)?.text }
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func setupCollectionViewHandler() {
        collectionViewHandler = CollectionViewHandler(collectionView, items: [], target: self, refreshAction: #selector(refreshAction))
        
        collectionViewHandler.didSelectItem = { [weak self] item in
            self?.coordinator?.navigateToPhoto(with: item.url ?? "")
        }
    }
    
    @objc func refreshAction() {
        viewModel.fetchPhotos()
    }
    
    func setupNavigationItem() {
        navigationItem.title = viewModel.album.title?.capitalized

        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(toggleShowSearchBar), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func toggleShowSearchBar() {
        // Toggle the visibility of the hidden view with animation
        let isViewVisible = self.searchBar.alpha.isEqual(to: 1)
        let viewHeight: CGFloat = 16 + 44 + 8
        
        debugPrint("isViewVisible: \(isViewVisible)")
        UIView.animate(withDuration: 0.5) {
            self.collectionViewTopConstraint.constant = isViewVisible ? 16 : viewHeight
            self.searchBar.alpha = isViewVisible ? 0.0 : 1.0
            self.searchBar.isUserInteractionEnabled = !isViewVisible
            self.view.layoutIfNeeded()
        }
    }

}
