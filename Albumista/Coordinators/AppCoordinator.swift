//
//  AppCoordinator.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import UIKit
import SDWebImage
import SKPhotoBrowser

protocol AppCoordinating: BaseCoordinator {
    func navigateToHome()
    func navigateToProfile()
    func navigateToAlbumDetails(album: AlbumModel)
    func navigateToPhoto(with urlString: String)
}

final class AppCoordinator: AppCoordinating {
    
    // MARK: - Properties
    weak var parentCoordinator: BaseCoordinator? = nil
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Init
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    func start() {
        navigateToHome()
    }
    
    func navigateToHome() {
        let viewModel = HomeViewModel()
        let vc = HomeVC(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToProfile() {
        let viewModel = ProfileViewModel()
        let vc = ProfileVC(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToAlbumDetails(album: AlbumModel) {
        let viewModel = AlbumDetailsViewModel(album: album)
        let vc = AlbumDetailsVC(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToPhoto(with urlString: String) {
        let url = URL(string: urlString)
        // Use SDWebImageManager to load the image
        SDWebImageManager.shared.loadImage(with: url, options: .retryFailed, progress: nil) { [weak self] (image, _, error, _, _, _) in
            DispatchQueue.main.async {
                if let downloadedImage = image {
                    let photo = SKPhoto.photoWithImage(downloadedImage)
                    let browser = SKPhotoBrowser(photos: [photo])
                    self?.navigationController.present(browser, animated: true)
                } else {
                    // Error occurred or no image downloaded
                    debugPrint("Error downloading image at \(urlString): \(error?.localizedDescription ?? "No Image")")
                    if let error {
                        self?.navigationController.showErrorAlert(bodyMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func finish() {
        childCoordinators.removeAll()
        parentCoordinator?.back(toRoot: true)
    }
    
    deinit{
        print("\(Self.self) deallocated")
    }
}
