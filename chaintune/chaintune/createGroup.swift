//
//  createGroup.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/8/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI
import Firebase

struct createGroup: View {
    @State private var groupName: String = "";
    @State private var sizeGroup: String = "";

     var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                        TextField("Name of Group: ", text: $groupName)
                        HStack {
                            TextField("Number of People: ", text: $sizeGroup)
                            Text("Max: 5").foregroundColor(.red)
                        }

                        Spacer()
                    HStack(alignment: .center) {
                            Spacer().frame(width: 170)
                            Button("Create") {
                                print("Create Group!")
                                self.getGroup(name: self.groupName, size: self.sizeGroup)
                                print("Success!")
                            }
                        }
                        
                        Spacer()
                    
                    }.padding()
                
            }.navigationBarTitle("Create Group")
        }.edgesIgnoringSafeArea(.leading)
        
        
        
    }
    
    func getGroup(name: String, size: String) {
        var ref: DocumentReference? = nil
        
        ref = db.collection("userTest").addDocument(data: [
            "name": name,
            "size": size
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}



struct createGroup_Previews: PreviewProvider {
    static var previews: some View {
        createGroup()
    }
}
