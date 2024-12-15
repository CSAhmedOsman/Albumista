//
//  HomeViewModel.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    private var userAlbums: [AlbumModel] = []
    @Published var albums: [AlbumModel] = []
    @Published var errorMessage: String?
    
    private let userRepository: UserRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func fetchUser() {
        if AppUser.sheared.user == nil{
            let userId = AppUser.sheared.userId
            userRepository.fetchUser(userId: userId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { user in
                    AppUser.sheared.user = user
                })
                .store(in: &cancellables)
        }
    }
    
    func fetchAlbums() {
        let userId = AppUser.sheared.userId
        userRepository.fetchAlbums(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] albums in
                self?.userAlbums = albums
                self?.albums = albums
            })
            .store(in: &cancellables)
    }
    
    func searchAlbums(with text: String) {
        guard !text.isEmpty else {
            self.albums = userAlbums
            return
        }
        
        let filteredItems = self.userAlbums.filter({ $0.title?.lowercased().contains(text.lowercased()) ?? false })
        self.albums = filteredItems
    }
}
