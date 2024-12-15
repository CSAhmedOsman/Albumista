//
//  PhotoModel.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import Foundation

struct PhotoModel: Codable {
    
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        albumId = try container.decodeIfPresent(Int.self, forKey: .albumId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }

}
