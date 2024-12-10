//
//  Address.swift
//  Albumista
//
//  Created by Mac on 10/12/2024.
//

import Foundation

struct Address: Codable {
    
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    enum CodingKeys: String, CodingKey {
        case zipcode
        case geo
        case street
        case city
        case suite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        geo = try container.decodeIfPresent(Geo.self, forKey: .geo)
        street = try container.decodeIfPresent(String.self, forKey: .street)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        suite = try container.decodeIfPresent(String.self, forKey: .suite)
    }
    
}
