//
//  BaseCoordinator.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import UIKit

protocol BaseCoordinator: AnyObject {
    var parentCoordinator: BaseCoordinator? { get set }
    var childCoordinators: [BaseCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func back(toRoot: Bool)
    func finish()
}

extension BaseCoordinator {
    
    func back(toRoot: Bool = false){
        if toRoot{
            navigationController.popToRootViewController(animated: true)
        }else {
            navigationController.popViewController(animated: true)
        }
    }
}

