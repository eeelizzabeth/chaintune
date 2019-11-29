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
       @Published var userSession: User?
       @Published var isLoggedIn: Bool?
       @Published var items: [Record] = []

     
       
       //MARK: Functions
       func listen() {
           _ = Auth.auth().addStateDidChangeListener { (auth, user) in
               if let user = user {
                   self.userSession = User(uid: user.uid, displayName: user.displayName, email: user.email)
                   self.isLoggedIn = true
               } else {
                   self.isLoggedIn = false
                   self.userSession = nil
               }
           }
       }
       
       func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
           Auth.auth().signIn(withEmail: email, password: password, completion: handler)
       }
       
       func logOut() {
               try! Auth.auth().signOut()
               self.isLoggedIn = false
               self.userSession = nil

       }
       
       func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
           Auth.auth().createUser(withEmail: email, password: password, completion: handler)
       }
      

}
