//
//  Geo.swift
//  Albumista
//
//  Created by Mac on 10/12/2024.
//

import Foundation

struct Geo: Codable {
    
    var lat: String?
    var lng: String?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        lng = try container.decodeIfPresent(String.self, forKey: .lng)
    }
    
}
