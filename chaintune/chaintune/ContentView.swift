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
    @EnvironmentObject var session: FirebaseSession
      
      var body: some View {
          
          NavigationView{
              if session.userSession != nil {
                    home()
//                    mockCounting()
                    

              }else{
//                CircularProgressBar()
//                mockCounting()
//                Login()
                  home()
                
              }
          }
          .onAppear(perform: getUser)
          
      }
      
      func getUser() {
          session.listen()
      }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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




