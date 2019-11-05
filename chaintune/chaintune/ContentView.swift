//
//  ContentView.swift
//  chaintune
//
//  Created by Iris Manriquez on 10/29/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var username = "placehokder"
    @State var password = "123"
    
    var body: some View {
        NavigationView {
            VStack(){
                TextField("Username", text: $username).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                TextField("Password", text: $password).background(Color.white)
                .padding()
                Button(action: {}){
                    HStack{
                        Text("Login")

                    }
                }
            }
            .navigationBarTitle("Log In")
    
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(username: "", password: "")
    }
}

