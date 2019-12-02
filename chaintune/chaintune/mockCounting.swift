//
//  mockCounting.swift
//  chaintune
//
//  Created by Iris Manriquez on 11/28/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


struct mockCounting: View {
    @EnvironmentObject var session: FirebaseSession
     @State var timing = 0
//    @State var start: String
     @State var minutes: Double = 0
     @State  var seconds = 60

     var timer : Timer?
    
    var Timestamp: String {
       return "\(NSDate().timeIntervalSince1970 * 1000)"
    }
    var timerC: Timer? {

          Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timerC in
            let addTime = db.collection("users").document(self.session.userSession!.uid)
            self.seconds = self.seconds - 1
            self.timing = self.timing + 1
            if(self.seconds == 0 ){
                if(self.minutes == 0){
                    self.timerC?.invalidate()
                    addTime.collection("Records").addDocument(data: [
                        "Start": FieldValue.serverTimestamp(),
                        "Duration": self.timing,
                        "Complete": true
                     ])
                    
                }
                self.minutes = self.minutes - 1
                self.seconds = 60
            }
            
            
          }
      }
      
      var body: some View {
        VStack{
            Slider(value: $minutes, in: 5.0...120.0, step: 5.0)
            Text(countDownString(minutes: Int(minutes), seconds: seconds))
                  .font(.largeTitle)
                  .onTapGesture(perform: {
                      _ = self.timerC

                  })
       
            Button(action: {
                self.session.userSession?.totalTime = (self.session.userSession?.totalTime ?? 0) + self.timing
                let addTime = db.collection("users").document(self.session.userSession!.uid)

                self.timerC?.invalidate()
                addTime.collection("Records").addDocument(data: [
                    "Start": FieldValue.serverTimestamp(),
                    "Duration": self.timing,
                    "Complete": false
                ])
                   }){
                       Text("Stop")
                   }
        }
       
        
      }

    func countDownString(minutes: Int, seconds: Int) -> String {
        if (seconds == 60){
            return String(format: "%02dm:%02ds",
                                   minutes ,
                                   0 )
            
        }
          return String(format: "%02dm:%02ds",
                        minutes ,
                        seconds )
      }

}


