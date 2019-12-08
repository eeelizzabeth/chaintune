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
    
    @ObservedObject var stopwatch = Stopwatch()
    @State var minutes: Double = 0
    @State var isFlipped = true
    var body: some View {
            VStack {
                
                Slider(value: $minutes, in: 5.0...120.0, step: 5.0)
                Text(isFlipped ? countDownString(minutes: Int(self.minutes), seconds: self.stopwatch.seconds): countDownString(minutes: Int(self.stopwatch.minutes), seconds: self.stopwatch.seconds))
                                        .font(.largeTitle)
                    .onTapGesture {
                        self.stopwatch.start(mins: Int(self.minutes))
                        self.isFlipped.toggle()

                }
//
               
                                       

                                       
                

//
                    Button(action: {
                        self.stopwatch.stop()
                    }) {
                        Text("Stop")
                    }
//                    Button(action: {
//                        self.stopwatch.reset()
//                    }) {
//                        Text("Reset")
//                    }
//
//                // 3.
//                Text("\(self.stopwatch.counter)")
            }.font(.largeTitle)
        
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

struct mockCounting_Previews: PreviewProvider {
    static var previews: some View {
        mockCounting()
    }
}
