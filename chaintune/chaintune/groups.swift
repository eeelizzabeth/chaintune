//
//  groups.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI

struct groupCell: View, Identifiable{
    var id = UUID()
    var name: String
    var profile: Image
    var body : some View {
        HStack {
            profile.resizable().frame(width:50, height: 50)
            Text(name)
        }
    }
}

struct groups: View {
    @State var groups = [
        groupCell(name:"Group1", profile:Image("profile1")),
        groupCell(name:"Group2", profile:Image("profile2"))
    ]
    var body: some View {
        List(groups) { group in
            groupCell(name:group.name, profile:group.profile)
        }
    }
}

struct groups_Previews: PreviewProvider {
    static var previews: some View {
        groups()
    }
}
