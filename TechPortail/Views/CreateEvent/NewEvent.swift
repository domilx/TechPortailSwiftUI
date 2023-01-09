//
//  NewEvent.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2023-01-08.
//

import SwiftUI

struct NewEvent: View {
  @State var dateBegin = Date()
  @State var dateEnd = Date()
  @State var name: String = ""
  @State var desc: String = ""
  @State var isFTC: Bool = false
  @State var isFRC: Bool = false
  @State var location: String = ""
    
    var locations = ["Online", "In person"]
    @State private var selectedLocation = 0
    
    var body: some View {
        NavigationView {
            
            List {
                Section(header: Text("General Info"), content: {
                    TextField("Name", text: $name)
                    TextField("Description", text: $desc)
                })
                Section(header: Text("Categories"), content: {
                    Toggle(isOn: $isFRC) {
                        Text("Event is FRC")
                    }
                    Toggle(isOn: $isFTC) {
                        Text("Event is FTC")
                    }
                })
                Section(header: Text("Location Details")) {
                    Picker(selection: $selectedLocation, label: Text("Location")) {
                        ForEach(0 ..< locations.count) {
                            Text(self.locations[$0])
                        }
                    }
                    TextField("Room or link to meeting", text: $location)
                }
                Section(header: Text("Dates")) {
                    DatePicker("Start Date", selection: $dateBegin)
                    DatePicker("End Date", selection: $dateEnd)
                }
                
                Button(action: {
                    print("aaa")
                }, label: {
                    HStack{
                        Spacer()
                        Text("Submit")
                        Spacer()
                    }
                })
            }.navigationTitle("New Event")
            
        }
    }
}

struct NewEvent_Previews: PreviewProvider {
  static var previews: some View {
    NewEvent()
  }
}
