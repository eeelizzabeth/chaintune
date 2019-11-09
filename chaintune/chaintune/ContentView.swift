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
     var body: some View {
            Login()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Login: View {
    @State var username = "placehokder"
    @State var password = "123"
    @State var shown = false
    @State var msg = ""

    
    
    var body: some View {
        NavigationView {
            VStack(){
                TextField("Username", text: $username).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                TextField("Password", text: $password).background(Color.white)
                .padding()
                HStack{
                    Button(action: {
                        Auth.auth().signIn(withEmail: self.username, link: self.password){ (res, err) in
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
                    Button(action: {
                        Auth.auth().createUser(withEmail: self.username, password: self.password){ (res, err) in
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

