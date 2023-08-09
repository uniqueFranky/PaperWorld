//
//  CoreData.swift
//  PaperWorld
//
//  Created by 闫润邦 on 2023/8/9.
//

import Foundation
import CoreData
import UIKit

class UserData {
    static let defaultStand = UserDefaults.standard
    
    static func fetchUserName() -> String? {
        return defaultStand.string(forKey: "userName")
    }
    
    static func fetchAvatar() -> Data? {
        return defaultStand.data(forKey: "avatar")
    }
    
    static func update(userName: String) {
        defaultStand.set(userName, forKey: "userName")
    }
    
    static func update(avatar data: Data) {
        defaultStand.set(data, forKey: "avatar")
    }
}
