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

// 1.
class Stopwatch: ObservableObject {
    // 2.
    @Published var counter: Int = 0
    @Published var timing = 0
    @Published var minutes: Int = 0
    @Published var seconds = 60
    var timer = Timer()
    
    // 3.
    func start(mins: Int) {
        minutes = Int(mins)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
             self.seconds = self.seconds - 1
               self.timing = self.timing + 1
               if(self.seconds == 0 ){
                   if(self.minutes == 0){
                       self.timer.invalidate()
                       
                       
                   }
                   self.minutes = self.minutes - 1

                   self.seconds = 60
            }
//            print(self.minutes)
        }

    }
    
    // 4.
    func stop() {
        timer.invalidate()
    }
    
    // 5.
    func reset() {
        counter = 0
        timer.invalidate()
    }
    
//    func countDownString() -> String {
//        if (seconds == 60){
//            return String(format: "%02dm:%02ds",
//                          minutes ,
//            0 )
//            
//        }
//           return String(format: "%02dm:%02ds",
//                                minutes ,
//                                seconds )
//    }
}
