//
//  ProfileViewModel.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {

    @Published var user: UserModel?
    @Published var errorMessage: String?
    
    private let userRepository: UserRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func fetchUser() {
        if let user = AppUser.sheared.user {
            self.user = user
        }else {
            let userId = AppUser.sheared.userId
            userRepository.fetchUser(userId: userId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] user in
                    self?.user = user
                    AppUser.sheared.user = user
                })
                .store(in: &cancellables)
        }
    }
}
