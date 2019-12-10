//
//  CircularProgressBar.swift
//  chaintune
//
//  Created by Elizabeth Hernandez on 12/7/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI

struct CircularProgressBar: View {
    @EnvironmentObject var session: FirebaseSession
    
    @ObservedObject var stopwatch = Stopwatch()
    @State var minutes: Double = 0
    @State var isFlipped = true
    
    //1. Create a State for keeping track of the bar's progress
    @State var circleProgress: CGFloat = 0.00
    var num: CGFloat = 12.0
    var num2: CGFloat = 260
    var num3: Double = -90
    
    
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    //2. Create the inner, static circle
                    Circle()
                        .stroke(Color.gray, lineWidth: num)
                        .frame(width: num2, height: num2)
                        .rotationEffect(Angle(degrees: num3))
                    //3. Create the outer, dynamic circle, depending on the States value
                    Circle()
                        .trim(from: 0.0, to: self.circleProgress)
                        .stroke(Color.purple, lineWidth: 12.0)
                        .frame(width: 200, height: 200)
                        .rotationEffect(Angle(degrees: -90))
                    
                    Spacer().frame(height: -65)
                }
                
                //4.Insert a Text showing the percentage value
                Text("\(Int(self.circleProgress)*100)%")
                    .font(Font.custom("Montserrat-Bold",size: 30))
                    .frame(width: 200, height: 100)
            }
            
            Slider(value: $minutes, in: 5.0...120.0, step: 5.0)
            Text(isFlipped ? countDownString(minutes: Int(self.minutes), seconds: self.stopwatch.seconds): countDownString(minutes: Int(self.stopwatch.minutes), seconds: self.stopwatch.seconds))
           .font(.largeTitle)
                .onTapGesture {
                    print(self.session.userSession!.uid)
                    self.stopwatch.sessionID = self.session.userSession!.uid 
                    self.stopwatch.start(mins: Int(self.minutes))
                                  self.isFlipped.toggle()
                                  self.start()
            }
            
            //5. Make the State representing the current progress, in this example we are
            //   "loading" one percent every second
            Button(action: {
              
            }) {
                Text("Button!!!!!!")
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

    func start() {
        var elapsed = 0
        let tempMin: CGFloat = CGFloat(self.stopwatch.minutes) * 60

        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            if(elapsed == Int(tempMin)){
                timer.invalidate()
            }
//            print("Timer fired!!")
            elapsed = elapsed + 1
            
//            print(tempMin)
            print("ELA", elapsed)
            withAnimation {
//                    if tempMin == 0 {
//                        tempMin = 1
//                    }
//                self.circleProgress = ( (60 - CGFloat(self.stopwatch.seconds)) * tempMin ) * 0.017
                self.circleProgress = CGFloat(elapsed) / tempMin
//                self.circleProgress.round()
                
                
                print(self.circleProgress)
                print(self.stopwatch.minutes)
            }
        }
    }
    
    
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar()
    }
}
