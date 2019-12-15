//
//  CountDownTimer.swift
//  chaintune
//
//  Created by Iris Manriquez on 12/2/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//


import Foundation
import SwiftUI
import Combine
import Firebase

// 1.
class Stopwatch: ObservableObject {
    // 2.

    @Published var counter: Int = 0
    @Published var timing = 0
    @Published var minutes: Int = 0
    @Published var seconds = 60
    @Published var sessionID: String = "hold"

    var timer = Timer()
    
    // 3.Timer adjusting the time running
    func start(mins: Int) {
        minutes = 1
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.seconds = self.seconds - 1
            self.timing = self.timing + 1
            if(self.seconds == 0 || self.seconds == 59){
               self.seconds = 59

                  if(self.minutes == 0){
                    self.seconds = 0
                    self.addRecord(finished: true)
                    self.stop()
                      
                      
                  } else {
                    self.minutes = self.minutes - 1

                }

            }
              
            
            }

    }
    
    // 4.Stop timer
    func stop() {
        timer.invalidate()
    }
    
    // 5. Reset Timer
    func reset() {
        counter = 0
        timer.invalidate()
    }
    
    //6. Timer adding records to the databse
    func addRecord(finished: Bool){
      let userRecord = db.collection("users").document(self.sessionID)
       
      if(finished){
        _ = userRecord.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!["Total"] as! Int
                userRecord.updateData([
                    "Total": dataDescription + self.timing
                ])
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        
      }
    
        
        userRecord.collection("Records").addDocument(data: [
              "Start":  Timestamp(date: Date()),
              "Duration": self.timing,
              "Complete": finished

          ])
        }
    

}
