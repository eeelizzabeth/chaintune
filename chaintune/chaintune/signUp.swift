//
//  signUp.swift
//  chaintune
//
//  Created by Iris Manriquez on 11/28/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI

struct signUp: View {
    @EnvironmentObject var session: FirebaseSession

    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var shown = false
    @State var msg = ""
    
    var body: some View {
        NavigationView{
            VStack(){
                
                TextField("Name", text: $name).background(Color.white).padding()
                TextField("Email", text: $email).background(Color.white).padding()
                TextField("Password", text: $password).background(Color.white).padding()
                
                   Button(action: {
                            self.session.signUp(email: self.email, password: self.password) {(res, err) in
                                if err != nil {
                                    print((err!.localizedDescription))
                                    self.msg = err!.localizedDescription
                                    self.shown.toggle()
                                    return
                                }
                                db.collection("users").document(self.session.userSession!.uid).setData([
                                    "Name": self.name,
                                    "Email": self.email,
                                    "Password": self.password,
                                    "Total": 0,
                                    "StreakDays": 0,
                                    "Streak": false
                                ])
                            self.session.listen()
                            self.msg = "Success"
                            self.shown.toggle()
                
                            }
                        }){

                    Text("Sign Up")
                }

            }

        }
    }
}
