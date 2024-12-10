//
//  AlbumModel.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import Foundation

struct AlbumModel: Codable {
    
    var id: Int?
    var userId: Int?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    
}
