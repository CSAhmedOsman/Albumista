//
//  AppUser.swift
//  Albumista
//
//  Created by Mac on 10/12/2024.
//

import Foundation

class AppUser {
    static var sheared = AppUser()
    
    @Published var user: UserModel?
    private var _userId: Int
    
    var userId: Int {
        return user?.id ?? _userId
    }
    
    private init() {
        _userId = Int.random(in: 1...10)
    }
    
}
