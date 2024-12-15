//
//  EndPoints.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import Foundation
import Moya

enum EndPoints: TargetType {

    case user(id: Int)
    case albums(userId: Int)
    case photos(albumId: Int)
    
    var baseURL: URL{
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
            case .user(let id): return "users/\(id)"
            case .albums: return "albums"
            case .photos: return "photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
            default: return .get
        }
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var parameters: [String : Any] {
        var params: [String : Any] = [:]
        switch self {
            case .albums(let userId):
                params[K.HomeParameter.userId] = userId
            case .photos(let albumId):
                params[K.HomeParameter.albumId] = albumId
            default:
                break
        }
        return params
    }
    
    var headers: [String : String]? { nil }
}
