//
//  friends.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI
import Firebase
struct friends: View {
    @EnvironmentObject var session: FirebaseSession
    @State var friendsList = [
        friendCell(id: "1234", name:"Emma Watson", profile: Image("profile1"), score: 21),
//        friendCell(name:"Billie Ellish", profile: Image("profile2")),
//        friendCell(name:"Chris Brown", profile:Image("profile3")),
//        friendCell(name:"Anne Hathaway", profile:Image("profile4")),
//        friendCell(name:"Anna Farris", profile:Image("profile1"))
    ]
       
    var body: some View {
        VStack {
            Button(action: {
               _ = db.collection("users").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let current = document.data()
                            let newFriend = friendCell(id: current["ID"] as! String, name: current["Name"] as! String, profile:Image("profile1"), score: 6)
                            if( current["ID"] as! String == String(self.session.userSession?.uid ?? "noID")){
                                continue
                            }
                        
                                
                            self.friendsList.append(newFriend)
                            
                            print("\(document.documentID) => \(document.data())")
                        }
                    }
                
                }
                print("pressed")
            }){
                Text("TEST")
            }
          
            List (friendsList) { friend in
                friendCell(id: friend.id, name: friend.name, profile: friend.profile, score: friend.score)
            }
        }
    }
    
}
struct friends_Previews: PreviewProvider {
    static var previews: some View {
        friends()
    }
}
