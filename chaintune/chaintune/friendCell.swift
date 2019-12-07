//
//  friendCell.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI


struct friendCell: View, Identifiable {
    var id = UUID()
    var name: String
    var profile: Image
    var body: some View {
        HStack {
            profile.resizable().frame(width:50, height: 50)
            Text(name)
        }
        
    }
}

struct friendCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            friendCell(name:"Alex Maunver", profile: Image("profile1"))
        }
        .previewLayout(.fixed(width:300, height:70))
    }
}
