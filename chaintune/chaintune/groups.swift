//
//  groups.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI

//struct groupCell: View, Identifiable{
//    var id = UUID()
//    var name: String
//    var profile: Image
//    var body : some View {
//        HStack {
//            profile.resizable().frame(width:50, height: 50)
//            Text(name)
//        }
//    }
//}


struct groups: View {
    @EnvironmentObject var session: FirebaseSession

    @State var currFriends = [friendCell]()
    @State var friendArray = [String()]
    var body: some View {
        VStack(){

            Button(action: {
                
                _ = db.collection("users").whereField("ID", isEqualTo: self.session.userSession!.uid).getDocuments() { (querySnapshot, err) in
                                 if let err = err {
                                     print("Error getting documents: \(err)")
                                 } else {
                                     for document in querySnapshot!.documents {
                                         let current = document.data()
                                        self.friendArray = current["Friends"] as! [String]

                                     }
                                 }

                             }
            }) { Text("Pull Friend List")
            }
                Button(action: {
                    _ = db.collection("users").whereField("ID", in: self.friendArray).getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            self.currFriends.removeAll()
                                            for document in querySnapshot!.documents {
                                                let current = document.data()
                                               let newFriend = friendCell(id: current["ID"] as! String, name: current["Name"] as! String, profile:Image("profile1"), score: current["Total"] as! Int, pressed: true)
                                                 print(current["Friends"] as! [String])
                                                
                                                self.currFriends.append(newFriend)

                                            }
                                        }

                                    }
                }){
                    Text("See Friends")
                }
            List (currFriends) { friend in
                      friendCell(id: friend.id, name: friend.name, profile: friend.profile, score: friend.score, pressed: true)
            }
        
      
        }
}
}

//func getUser(array: [String]) -> [String]{
//    _ = db.collection("users").whereField("ID", in: array).getDocuments() { (querySnapshot, err) in
//                      if let err = err {
//                          print("Error getting documents: \(err)")
//                      } else {
//                          for document in querySnapshot!.documents {
//                              let current = document.data()
//                             
//                              print(current)
//
//                          }
//                      }
//
//                  }
//    return array
//}
