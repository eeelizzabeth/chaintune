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
    
    let ref: DatabaseReference?
    let key: String
    let duration: Int
    let startTime: String
    let endTime: String
    let id: String
    
    init(duration: Int, startTime: String, endTime: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.duration = 0
        self.startTime = String()
        self.endTime = String()
        self.id = key
    }
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let duration = value["duration"] as? Int,
            let startTime = value["startTime"] as? String,
            let endTime = value["endTime"] as? String
        else {
                return nil
            }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.duration = duration
        self.startTime = startTime
        self.endTime = endTime
        self.id = snapshot.key
    }
    
    func toAnyObject() -> Any {
        return [
            "duration": duration,
            "startTime": startTime,
            "endTime": endTime,
        ]
    }
}

