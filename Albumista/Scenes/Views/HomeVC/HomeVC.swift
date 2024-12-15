//
//  HomeVC.swift
//  Albumista
//
//  Created by Mac on 10/12/2024.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    var userView: ProfileView!
    
    weak var coordinator: AppCoordinating?
    private var viewModel: HomeViewModel
    
    private var tableViewHandler: TableViewHandler<AlbumModel, AlbumTableViewCell>!
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
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
        setupTableViewHandler()
        setupUI()
        viewModel.fetchUser()
        viewModel.fetchAlbums()
    }
    
    private func setupUI() {
        searchBarPublisher().sink { [weak self] value in
            self?.viewModel.searchAlbums(with: value)
        }.store(in: &cancellables)
        
        AppUser.sheared.$user.sink { [weak self] user in
            if let user {
                self?.userView.setUsernameAndImage(user: user)
            }
        }.store(in: &cancellables)
        
        viewModel.$albums.sink { [weak self] items in
            self?.tableViewHandler.didItemsChanged(with: items)
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
    
    func setupTableViewHandler() {
        tableViewHandler = TableViewHandler(tableView, items: [], rowHeight: 72, target: self, refreshAction: #selector(refreshAction))
        
        tableViewHandler.didSelectItem = { [weak self] item in
            self?.coordinator?.navigateToAlbumDetails(album: item)
        }
    }
    
    @objc func refreshAction() {
        viewModel.fetchAlbums()
    }
    
    func setupNavigationItem() {
        userView = ProfileView(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.width ?? 0), height: self.navigationController?.navigationBar.frame.height ?? 0))
        userView.contentView.backgroundColor = .clear
        userView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToProfile))
        userView.addGestureRecognizer(tapGesture)
        
        let leftBarButtonItem = UIBarButtonItem(customView: userView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(toggleShowSearchBar), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func navigateToProfile() {
        coordinator?.navigateToProfile()
    }
    
    @objc func toggleShowSearchBar() {
        // Toggle the visibility of the hidden view with animation
        let isViewVisible = self.searchBar.alpha.isEqual(to: 1)
        let viewHeight: CGFloat = 16 + 44 + 8
        
        debugPrint("isViewVisible: \(isViewVisible)")
        UIView.animate(withDuration: 0.5) {
            self.tableViewTopConstraint.constant = isViewVisible ? 16 : viewHeight
            self.searchBar.alpha = isViewVisible ? 0.0 : 1.0
            self.searchBar.isUserInteractionEnabled = !isViewVisible
            self.view.layoutIfNeeded()
        }
    }
}
