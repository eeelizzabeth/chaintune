//
//  Record.swift
//  chaintune
//
//  Created by Iris Manriquez on 11/19/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import Foundation

import SwiftUI
import FirebaseDatabase

struct Record: Identifiable {
    
    let key: String
    let duration: Int
    let startTime: String
    let endTime: String
    let id: String
    
    init(duration: Int, startTime: String, endTime: String, key: String = "") {
        self.key = key
        self.duration = 0
        self.startTime = String()
        self.endTime = String()
        self.id = key
    }

    func toAnyObject() -> Any {
        return [
            "duration": duration,
            "startTime": startTime,
            "endTime": endTime,
        ]
    }
}

