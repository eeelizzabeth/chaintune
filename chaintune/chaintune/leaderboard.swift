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
        TabView {
              friends()
                  .tabItem {
                      Text("Global")
              }
              groups()
                  .tabItem {
                    Text("Friends")
                }
            }
            .navigationBarTitle("Leaderboard")
            .scaledToFit()
         
    }
}

struct leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        leaderboard()
    }
}
