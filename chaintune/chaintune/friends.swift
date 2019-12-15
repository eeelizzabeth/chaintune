//
//  friends.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct friends: View {
    @EnvironmentObject var session: FirebaseSession
    @State var friendsList = [
        friendCell(id: "qj2HLYVWqBbuqog7m9cp", name:"Emma Watson", profile: Image("profile1"), score: 6490, pressed: false),
        friendCell(id: "SKSvbalTYFEtOCfpswgw", name:"Billy Harvey", profile: Image("profile2"), score: 5409, pressed: false),
        friendCell(id: "vKlOJnHHFkpv15NDE2YD", name:"Ann Stevens", profile: Image("profile3"), score: 4231, pressed: false)

    ]
    var body: some View {
        VStack {
        
            List (friendsList) { friend in
                friendCell(id: friend.id, name: friend.name, profile: friend.profile, score: friend.score, pressed: false)
            }
            
            Button(action: {
                _ = db.collection("users").order(by: "Total", descending: true).getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let current = document.data()
                                if( current["ID"] as! String == String(self.session.userSession?.uid ?? "noID")){
                                    continue
                                }
                                let newFriend = friendCell(id: current["ID"] as! String, name: current["Name"] as! String, profile:Image("profile1"), score: current["Total"] as! Int, pressed: false)
                                 print(current["Friends"] as! [String])
                                self.friendsList.append(newFriend)

                            }
                        }

                    }
                
            }){
                Text("Show More")
                    }
        }
    }
    
}
struct friends_Previews: PreviewProvider {
    static var previews: some View {
        friends()
    }
}
