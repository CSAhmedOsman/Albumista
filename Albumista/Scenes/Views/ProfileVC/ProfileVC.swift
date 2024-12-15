//
//  ProfileVC.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import UIKit
import Combine

class ProfileVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userWebsite: UILabel!
    @IBOutlet weak var addressStreetAndSuite: UILabel!
    @IBOutlet weak var addressCityAndZipcode: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyCatchPhrase: UILabel!
    @IBOutlet weak var companyTagline: UILabel!
    
    var viewModel: ProfileViewModel
    weak var coordinator: AppCoordinating?
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        viewModel.fetchUser()
    }
    
    private func setupUI() {
        
        viewModel.$errorMessage.sink { [weak self] errorMessage in
            if let errorMessage {
                self?.showErrorAlert(bodyMessage: errorMessage)
            }
        }.store(in: &cancellables)
        
        viewModel.$user.sink { [weak self] user in
            if let user {
                self?.name.text = user.name
                self?.userName.text = user.username
                self?.userPhone.text = user.phone
                self?.userEmail.text = user.email
                self?.userWebsite.text = user.website
                self?.addressStreetAndSuite.text = (user.address?.street ?? "") + ", " + (user.address?.suite ?? "")
                self?.addressCityAndZipcode.text = (user.address?.city ?? "") + ", " + (user.address?.zipcode ?? "")
                self?.companyName.text = user.company?.name
                self?.companyCatchPhrase.text = user.company?.catchPhrase
                self?.companyTagline.text = user.company?.bs
            }
        }.store(in: &cancellables)
    }
}
