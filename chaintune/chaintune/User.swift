//
//  User.swift
//  chaintune
//
//  Created by Iris Manriquez on 11/19/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import Foundation

class User {
    
    var uid: String
    var email: String?
    var displayName: String?
    var items: [Record] = []
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.items = []
    }
    
    func addRecord(record: Record){
        self.items.append(record)
    }
}
