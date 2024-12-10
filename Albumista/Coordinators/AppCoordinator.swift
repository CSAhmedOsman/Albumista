//
//  AppCoordinator.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import UIKit

protocol AppCoordinating: BaseCoordinator {
    func navigateToHome()
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
        let vc = ProfileVC(viewModel: NSObject())
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func finish() {
        childCoordinators.removeAll()
        parentCoordinator?.back(toRoot: true)
    }
    
    func navigateToHome() {
        
    }
    
    deinit{
        print("\(Self.self) deallocated")
    }
}
