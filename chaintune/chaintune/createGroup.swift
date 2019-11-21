//
//  createGroup.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/8/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI

struct createGroup: View {
    @State private var groupName: String = "";
    @State private var sizeGroup: String = "";

     var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                    TextField("Name of Group: ", text: $groupName)
                    HStack {
                        TextField("Number of People: ", text: $sizeGroup)
                        Text("Max: 5").foregroundColor(.red)
                    }

                    Spacer()
                }.padding()
            .navigationBarTitle("Create Group")
        }
        
    }
}

struct createGroup_Previews: PreviewProvider {
    static var previews: some View {
        createGroup()
    }
}
