//
//  AppDelegate.swift
//  chaintune
//
//  Created by Iris Manriquez on 10/29/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//


import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore

let db = Firestore.firestore()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var googleSign: Bool = false
    var uidTemp: String = ""
    
   func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      // ...
      if let error = error {
        // ...
        print(error.localizedDescription)
        return
      }

      guard let authentication = user.authentication else { return }
      
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
    let session = FirebaseSession.shared

    Auth.auth().signIn(with: credential) { (res, error) in
        self.googleSign = true
        self.uidTemp = (res?.user.uid)!
        db.collection("users").document((res?.user.uid)!).setData([
                "Name": res?.user.displayName ?? "No name",
                "Email": res?.user.email ?? "No email",
                "Total": 0,
                "StreakDays": 0,
                "Streak": false
            ])
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if(self.googleSign){
            let userRecord = db.collection("users").document(self.uidTemp)
            
             
             userRecord.collection("Records").addDocument(data: [
                   "Start":  Timestamp(date: Date()),
                   "Duration": -1,
                   "Complete": false

               ])
        } else {
            let session = FirebaseSession.shared

            let userRecord = db.collection("users").document(session.userSession!.uid)
                     
                      
                      userRecord.collection("Records").addDocument(data: [
                            "Start":  Timestamp(date: Date()),
                            "Duration": -1,
                            "Complete": false

                        ])
        }

      
        print("APP CLOSED")
    }
    
    

}


