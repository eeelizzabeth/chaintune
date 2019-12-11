//
//  friendCell.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//
import SwiftUI
import Firebase
struct friendCell: View, Identifiable, Comparable {
    static func == (lhs: friendCell, rhs: friendCell) -> Bool {
          if(lhs.id == rhs.id){
              return true
          }
          return false
      }
    static func < (lhs: friendCell, rhs: friendCell) -> Bool {
        if(lhs.id == rhs.id){
            return false
         }
        return true
    }
    
  
    
    @EnvironmentObject var session: FirebaseSession
    var id: String
    var name: String
    var profile: Image
    var score: Int
    @State var pressed = false
    var body: some View {
        HStack {
            profile.resizable().frame(width:50, height: 50)
            Text(name)
            Text(String(score))
            Button(action: {
                self.pressed.toggle()
                db.collection("users").document(self.session.userSession!.uid).updateData([
                    "Friends":  FieldValue.arrayUnion(["\(self.id)"])
                ])
                { err in
                if let err = err {
                  print("Error writing document: \(err)")
                } else {
                print("Document successfully written!")
                           }
                }
            }){
                if(pressed){
                    Text("Added")
                } else{
                   Text("Add Friend")
                }
            }
        }
        
    }
}
