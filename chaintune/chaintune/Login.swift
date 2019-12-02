//
//  Login.swift
//  chaintune
//
//  Created by Iris Manriquez on 11/28/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var session: FirebaseSession
    @State var username = ""
    @State var password = ""
    @State var shown = false
    @State var msg = ""

    
    
    var body: some View {
        NavigationView {
            VStack(){
                TextField("Email", text: $username).background(Color.white)
                    .padding()
                TextField("Password", text: $password).background(Color.white)
                .padding()
                HStack{
                    Button(action: {
                        self.session.logIn(email: self.username, password: self.password){ (res, err) in
                            if err != nil {
                                print((err!.localizedDescription))
                                self.msg = err!.localizedDescription
                                self.shown.toggle()
                                return
                            }
                            self.msg = "Success"
                            self.shown.toggle()
                        }
                    }){
                                       
                        Text("Login")
                    }
                    NavigationLink(destination: signUp()) {
                                  Text("Sign Up")
                    }
                }.alert(isPresented: $shown){
                    return Alert(title: Text(self.msg))
                }
               
                google().frame(width: 120, height: 50, alignment: .center)
               
            }
            .navigationBarTitle("Log In")
    
        }
        
    }
    
}
