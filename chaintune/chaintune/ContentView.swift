//
//  ContentView.swift
//  chaintune
//
//  Created by Iris Manriquez on 10/29/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn



struct ContentView: View {
    @ObservedObject var session = FirebaseSession()


     var body: some View {
        Login(session: self.session)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Login: View {
    @ObservedObject var session: FirebaseSession
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
                            self.session.uploadRecord(user: self.username, duration: 554, startTime: "skjm", endTime:"sda")
                            self.msg = "Success"
                            self.shown.toggle()
                        }
                    }){
                                       
                        Text("Login")
                    }
                    NavigationLink(destination: signUp(session: self.session)) {
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

struct google: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}


struct signUp: View {
    @ObservedObject var session: FirebaseSession

    
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
                            self.session.listen()
                            self.session.uploadRecord(user: self.name, duration: 554, startTime: "skjm", endTime:"sda")
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

