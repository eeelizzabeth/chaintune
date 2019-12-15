//
//  settings.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/30/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI

struct settings: View {
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        NavigationView {
            Text("Hello \(self.session.userSession!.displayName ?? "hwl")!")
            VStack{
                Button(action: {
                    self.session.logOut()
                }){
                    Text("Logout").foregroundColor(.black)
                }
                
            }
        
    }
        
}
}

struct settings_Previews: PreviewProvider {
    static var previews: some View {
        settings()
    }
}
