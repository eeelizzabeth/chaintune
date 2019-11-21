//
//  FirebaseSession.swift
//  chaintune
//
//  Created by Iris Manriquez on 11/19/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseSession: ObservableObject {
       @Published var session: User?
       @Published var isLoggedIn: Bool?
       @Published var items: [Record] = []

       var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
       
       //MARK: Functions
       func listen() {
           _ = Auth.auth().addStateDidChangeListener { (auth, user) in
               if let user = user {
                   self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                   self.isLoggedIn = true
                   self.getRecords()
               } else {
                   self.isLoggedIn = false
                   self.session = nil
               }
           }
       }
       
       func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
           Auth.auth().signIn(withEmail: email, password: password, completion: handler)
       }
       
       func logOut() {
               try! Auth.auth().signOut()
               self.isLoggedIn = false
               self.session = nil

       }
       
       func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
           Auth.auth().createUser(withEmail: email, password: password, completion: handler)
       }
      
       func getRecords() {
           ref.observe(DataEventType.value) { (snapshot) in
               self.items = []
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let record = Record(snapshot: snapshot) {
                       self.items.append(record)
                   }
               }
           }
       }
       
    func uploadRecord(user: String, duration: Int, startTime: String, endTime: String) {
           //Generates number going up as time goes on, sets order of TODO's by how old they are.
//           let number = Int(String.timeIntervalSinceReferenceString * 1000)
           
           let postRef = ref.child(String(user))
           let post = Record(duration: duration, startTime: startTime, endTime: endTime)
           postRef.setValue(post.toAnyObject())
       }
       
       func updateRecord(key: String, duration: String) {
           let update = ["duration": duration]
           let childUpdate = ["\(key)": update]
           ref.updateChildValues(childUpdate)
       }

}
