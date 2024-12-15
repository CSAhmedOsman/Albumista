//
//  Repository.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol UserRepositoryProtocol {
    func fetchUser(userId: Int) -> AnyPublisher<UserModel, MoyaError>
    func fetchAlbums(userId: Int) -> AnyPublisher<[AlbumModel], MoyaError>
    func fetchPhotos(albumId: Int) -> AnyPublisher<[PhotoModel], MoyaError>
}

class UserRepository: UserRepositoryProtocol {
    private let provider: MoyaProvider<EndPoints>
    
    init(provider: MoyaProvider<EndPoints> = MoyaProvider<EndPoints>()) {
        self.provider = provider
    }
    
    func fetchUser(userId: Int) -> AnyPublisher<UserModel, MoyaError> {
        return provider.requestPublisher(.user(id: userId))
            .map(UserModel.self)
            .eraseToAnyPublisher()
    }
    
    func fetchAlbums(userId: Int) -> AnyPublisher<[AlbumModel], MoyaError> {
        return provider.requestPublisher(.albums(userId: userId))
            .map([AlbumModel].self)
            .eraseToAnyPublisher()
    }
    
    func fetchPhotos(albumId: Int) -> AnyPublisher<[PhotoModel], MoyaError> {
        return provider.requestPublisher(.photos(albumId: albumId))
            .map([PhotoModel].self)
            .eraseToAnyPublisher()
    }
}
