//
//  Company.swift
//  Albumista
//
//  Created by Mac on 10/12/2024.
//

import Foundation

struct Company: Codable {
    
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        catchPhrase = try container.decodeIfPresent(String.self, forKey: .catchPhrase)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        bs = try container.decodeIfPresent(String.self, forKey: .bs)
    }
    
}
