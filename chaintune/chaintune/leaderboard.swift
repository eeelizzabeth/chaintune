//
//  leaderboard.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/14/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI

struct leaderboard: View {
    var body: some View {
        NavigationView {
            TabView {
                friends()
                    .tabItem {
                        Text("Friends")
                }
                groups()
                    .tabItem {
                        Text("Groups")
                }
            }
        }.navigationBarTitle("Leaderboard")
         
    }
}

struct leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        leaderboard()
    }
}
