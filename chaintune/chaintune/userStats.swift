//
//  userStats.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/29/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//

import SwiftUI
import JBCalendarDatePicker

// mode: 0 is Single date selection
var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)


var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}

struct userStats: View {
    @State var singleIsPresented = false
    @State var alreadySelectedDate = false
    
    //    @State private var selectedDate = Date() {
    //        didSet{
    //            self.updateDate()
    //        }
    //    }
    @State private var selectedDate: Date
    @State private var scoreSelectedDate = 0
    
    private var dateProxy: Binding<Date> {
        
        Binding<Date>(get: {self.selectedDate }, set: {
            self.selectedDate = $0
            self.singleIsPresented = false
            self.alreadySelectedDate = false
            
            self.updateDate()
            
        })
    }
    init() {
        self._selectedDate = State<Date> (initialValue: Date())
    }
    
    var body: some View {
        //        NavigationView {
        //            Text("Hello User!")
        //        }.navigationBarTitle("User Stats")
        
        VStack (spacing: 25) {
            VStack {
                // UI: datepicker
                Text("Score: \(scoreSelectedDate)").font(.largeTitle)
                Text("Date: \(selectedDate, formatter: dateFormatter)")
                
                Form {
                    Section {
                        DatePicker(selection: dateProxy, in: ...Date(), displayedComponents: .date) {
                            Text("Select a date")
                        }
                        Button(action: { self.singleIsPresented.toggle() }) {
                            Text("Click here to calendar view").foregroundColor(.blue)
                        }.sheet(isPresented: self.$singleIsPresented, content: {
                            RKViewController(isPresented: self.$singleIsPresented, rkManager: rkManager1)})
                    }
                }
                //                VStack{
                //
                //                    Text(self.getTextFromDate(date: self.rkManager1.selectedDate))
                //
                //                    Button(action: { self.singleIsPresented.toggle() }) {
                //                        Text("Click here to change Date Selection").foregroundColor(.blue)
                //                    }.sheet(isPresented: self.$singleIsPresented, content: {
                //                        RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1)})
                //                }
                
            }
            //            VStack {
            //                NavigationLink(destination: DestinationView()) {
            //                     Text("click me")
            //                }
            //            }
            
        }.onAppear(perform: startUp)
            .navigationBarTitle("User Stats")
            .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
    
    func startUp() {
        // calculate current date & time
        //change colors
        if(self.getTextFromDate(date: rkManager1.selectedDate) == ""){
            alreadySelectedDate = true
        }else{
            alreadySelectedDate = false
        }
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "No date selected" : formatter.string(from: date)
    }
    
    func updateDate() {
        print("==[Update score by date]==")
        // get records once
        let docRef = db.collection("users").document("dWJytQfOWbZFcbAYlUP8uFLLzlj2")
        print(docRef)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        //update score
        self.scoreSelectedDate = 100
    }
}

//let controller = UIHostingController(rootView: ViewController())
// remove this struct
struct DestinationView : View {
    
    var body: some View { Text("Calendar View") }
}

class ViewController: UIViewController {
    
    var datePicker: JBDatePickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = JBDatePickerViewController()
        view.addSubview(datePicker.view)
        addChild(datePicker)
        datePicker.didMove(toParent: self)
        self.datePicker = datePicker
        
        // Configure the datePicker's properties
    }
}

struct userStats_Previews: PreviewProvider {
    static var previews: some View {
        userStats()
    }
}
