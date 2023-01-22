//
//  NewEvent.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2023-01-08.
//

import SwiftUI

struct CreateEvent: View {
  @State var dateBegin = Date()
  @State var dateEnd = Date()
  @State var name: String = ""
  @State var desc: String = ""
  @State var isFTC: Bool = false
  @State var isFRC: Bool = false
  @State var location: String = ""
    
    @Binding var showModal: Bool
    
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
                    createEventModel()
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
    
    func createEventModel() {
        var eventToPub: NewEvent
        var types = [String]()
        
        var dateRawBegin: String = ISOStringFromDate(date: dateBegin)
        var dateRawEnd: String = ISOStringFromDate(date: dateEnd)

        if(isFRC) {
            types.append("FRC")
        }
        if(isFTC) {
            types.append("FTC")
        }
        if(selectedLocation == 0){
            eventToPub = NewEvent(name: name, description: desc, absents: [], presents: [], date_debut: dateRawBegin, date_fin: dateRawBegin, type: "distance", lien: location, local: "", users: [], categories: types)
            print(eventToPub)
            NewEventService().createEvent(event: eventToPub, completion: { string in
            })
        } else if(selectedLocation == 1){
            eventToPub = NewEvent(name: name, description: desc, absents: [], presents: [], date_debut: dateRawBegin, date_fin: dateRawBegin, type: "presence", lien: "", local: location, users: [], categories: types)
            print(eventToPub)
            NewEventService().createEvent(event: eventToPub, completion: { string in
            })
        }
        
        self.showModal.toggle()
        
    }
    
    func ISOStringFromDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            
            return dateFormatter.string(from: date)
        }
}



struct CreateEvent_Previews: PreviewProvider {
  static var previews: some View {
      CreateEvent(showModal: .constant(true))
  }
}
