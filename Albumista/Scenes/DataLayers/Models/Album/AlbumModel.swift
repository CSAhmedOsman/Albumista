//
//  AlbumModel.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import Foundation

struct AlbumModel: Codable {
    
    var userId: Int?
    var id: Int?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    
}
