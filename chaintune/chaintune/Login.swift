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
            VStack(alignment: .center){
                
                Image("chaintune")
                .resizable().frame(width:250, height: 250)
                
                Spacer().frame(height: 50)
        
                TextField("Email", text: $username).background(Color.white).frame(width: 300)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.green, lineWidth: 3)
                    )
                TextField("Password", text: $password).background(Color.white).frame(width: 300)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.green, lineWidth: 3)
                    )
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
                                       
                        Text("Login").foregroundColor(Color.red)
                    }
                    NavigationLink(destination: signUp()) {
                        Text("Sign Up").foregroundColor(Color.red)
                    }
                }.alert(isPresented: $shown){
                    return Alert(title: Text(self.msg))
                }
               
                google().frame(width: 120, height: 50, alignment: .center)
                
                
                Spacer().frame(height: 100)
               
            }
            .navigationBarTitle("Log In")
    
        }
        
    }
    
}
