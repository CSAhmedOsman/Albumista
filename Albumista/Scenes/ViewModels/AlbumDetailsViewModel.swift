//
//  AlbumDetailsViewModel.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import Foundation
import Combine

class AlbumDetailsViewModel: ObservableObject {
    
    @Published var album: AlbumModel
    private var userPhotos: [PhotoModel] = []
    @Published var photos: [PhotoModel] = []
    @Published var errorMessage: String?
    
    private let userRepository: UserRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(album: AlbumModel, userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
        self.album = album
    }
    
    func fetchPhotos() {
        guard let id = album.id else { return }
        
        userRepository.fetchPhotos(albumId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] photos in
                self?.userPhotos = photos
                self?.photos = photos
            })
            .store(in: &cancellables)
    }
    
    func searchAlbums(with text: String) {
        guard !text.isEmpty else {
            self.photos = userPhotos
            return
        }
        
        let filteredItems = self.userPhotos.filter({ $0.title?.lowercased().contains(text.lowercased()) ?? false })
        self.photos = filteredItems
    }
}
