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
    @State var friendsList = [
        friendCell(name:"Emma Watson", profile: Image("profile1")),
        friendCell(name:"Billie Ellish", profile: Image("profile2")),
        friendCell(name:"Chris Brown", profile:Image("profile3")),
        friendCell(name:"Anne Hathaway", profile:Image("profile4")),
        friendCell(name:"Anna Farris", profile:Image("profile1"))
    ]
    var body: some View {
        VStack {
            List (friendsList) { friend in
                friendCell(name: friend.name, profile: friend.profile)
            }
        }
    }
//    
//    func addFriend(friend: friendCell)
//    {
//        db.collection("userTest").document("Poq48Gx3IVQRXRRFSQvB")/*("\(friend.id)")*/.setData([
//            "name": friend.name,
//            "profile": friend.profile
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//    }

//    func addToDB(list: [friendCell]) {
//        for f in list {
//            addFriend(friend: f)
//        }
//    }
}

struct friends_Previews: PreviewProvider {
    static var previews: some View {
        friends()
    }
}
