//
//  ProfileVC.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import UIKit

class ProfileVC: UIViewController {
    
    private var viewModel: NSObject
    
    init(viewModel: NSObject) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
