//
//  UserModel.swift
//  Albumista
//
//  Created by Mac on 09/12/2024.
//

import Foundation

struct UserModel: Codable {
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        company = try container.decodeIfPresent(Company.self, forKey: .company)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        address = try container.decodeIfPresent(Address.self, forKey: .address)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        username = try container.decodeIfPresent(String.self, forKey: .username)
    }
    
    init(id: Int) {
        self.id = id
    }
    
}
