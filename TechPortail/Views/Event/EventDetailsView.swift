//
//  EventSheetView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-10-29.
//

import SwiftUI
import EventKit
import EventKitUI


struct EventDetailsView: View {
  var title: String
  var description: String
  var dateRawBegin: String
  var dateRawEnd: String
  var types: [String]
  var id: String
  var presences: [Present]
  var absences: [Absent]

  @AppStorage("userId") var userId: String = "null"

  @State private var showingAlert = false
  @State private var isPresent = false
  @State private var hasRegistered = false
  @State private var checked = false

  var body: some View {
      let dateBegin: Date = returnDate(date: dateRawBegin) ?? Date()
      let dateEnd: Date = returnDate(date: dateRawEnd) ?? Date()
      
      ScrollView{
          //summary of event
          HStack{
              VStack(alignment: .leading){
                  Text(title)
                      .font(.title)
                      .fontWeight(.bold)
                      .padding(.top, 10)
                      .padding(.bottom, 10)
                      .onAppear {
                          for presence in presences {
                          if presence.user?.id! == userId {
                            self.isPresent = true
                            self.hasRegistered = true
                          }
                        }
                        for absence in absences {
                          if absence.user?.id == userId {
                            self.isPresent = false
                            self.hasRegistered = true
                          }
                        }
                      }
                  VStack(alignment: .leading){
                      Text(description)
                          .padding(.bottom, 10)
                      Text("Begin Date: \(dateBegin.formatted())")
                      Text("End Date: \(dateEnd.formatted())")
                      Text("Types: \(types.joined(separator: ", "))")
                  }
                  .padding(.horizontal, 10.0)
                  .font(.body)
                    .fontWeight(.semibold)
                  HStack{
                      Spacer()
                      if(isPresent){
                          VStack(alignment: .center){
                              Text("Presence confirmed")
                                  .font(.title2)
                                  .fontWeight(.bold)
                                  .multilineTextAlignment(.leading)
                                  .padding(.top)
                              Text("Thank you for participating!")
                                  .font(.title3)
                                  .fontWeight(.bold)
                                  .multilineTextAlignment(.leading)
                                  .padding(.bottom)
                              
                              Button(action: {
                                  AbsenceService().putAbsence(event: id, completion: {bool in
                                      self.isPresent = bool
                                  })
                              }, label: {
                                  HStack(alignment: .firstTextBaseline, spacing: 6) {
                                      Text("Finally, I'm not going to be there")
                                          .foregroundColor(Color("red"))
                                  }
                                  .font(.body.weight(.medium))
                                  .padding(.vertical, 16)
                                  .frame(maxWidth: .infinity)
                                  .clipped()
                                  .foregroundColor(Color(.green))
                                  .background {
                                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                                          .fill(Color("red"))
                                          .opacity(0.2)
                                  }
                              })
                          }
                      }
                      if(!isPresent && hasRegistered){
                          VStack(alignment: .center){
                              Text("Confirmed absence")
                                  .font(.title2)
                                  .fontWeight(.bold)
                                  .multilineTextAlignment(.leading)
                                  .padding(.top)
                              Text("Oh no! Come back to us quickly!")
                                  .font(.title3)
                                  .fontWeight(.bold)
                                  .multilineTextAlignment(.leading)
                                  .padding(.bottom)
                              Button(action: {
                                  PresenceService().putPresence(debut: dateRawBegin, fin: dateRawEnd, event: id, completion: { bool in
                                      self.isPresent = bool
                                  })
                              }, label: {
                                  HStack(alignment: .firstTextBaseline, spacing: 6) {
                                      Text("Finally, I'm going to be there")
                                          .foregroundColor(Color("green"))
                                  }
                                  .font(.body.weight(.medium))
                                  .padding(.vertical, 16)
                                  .frame(maxWidth: .infinity)
                                  .clipped()
                                  .foregroundColor(Color(.green))
                                  .background {
                                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                                          .fill(Color("green"))
                                          .opacity(0.2)
                                  }
                              })
                          }
                      }
                      if(!isPresent && !hasRegistered){
                          VStack{
                              Text("Confirm your presence")
                                  .font(.title2)
                                  .fontWeight(.bold)
                                  .multilineTextAlignment(.leading)
                                  .padding(.top)
                              Text("Will you be attending the event?")
                                  .font(.title3)
                                  .fontWeight(.bold)
                                  .multilineTextAlignment(.leading)
                                  .padding(.bottom)
                              
                              Button(action: {
                                  PresenceService().putPresence(debut: dateRawBegin, fin: dateRawEnd, event: id, completion: { bool in
                                      self.isPresent = bool
                                  })
                              }, label: {
                                  HStack(alignment: .firstTextBaseline, spacing: 6) {
                                      Text("I will be present")
                                          .foregroundColor(Color("green"))
                                  }
                                  .font(.body.weight(.medium))
                                  .padding(.vertical, 16)
                                  .frame(maxWidth: .infinity)
                                  .clipped()
                                  .foregroundColor(Color(.green))
                                  .background {
                                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                                          .fill(Color("green"))
                                          .opacity(0.2)
                                  }
                              })
                              Button(action: {
                                  AbsenceService().putAbsence(event: id, completion: {bool in
                                      self.isPresent = bool
                                  })
                              }, label: {
                                  HStack(alignment: .firstTextBaseline, spacing: 6) {
                                      Text("I will not be present")
                                          .foregroundColor(Color("red"))
                                  }
                                  .font(.body.weight(.medium))
                                  .padding(.vertical, 16)
                                  .frame(maxWidth: .infinity)
                                  .clipped()
                                  .foregroundColor(Color(.green))
                                  .background {
                                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                                          .fill(Color("red"))
                                          .opacity(0.2)
                                  }
                              })
                          }
                      }
                      Spacer()
                  }

                  Text("Presences")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 10) {
                            ForEach(presences, id: \.id) { presence in
                                //A person logo and their name
                                VStack{
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color("green"))
                                    Text(presence.user?.name ?? "Unknown")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                  Text("Absences")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 10) {
                            ForEach(absences, id: \.id) { absence in
                                //A person logo and their name
                                VStack{
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color("red"))
                                    Text(absence.user?.name ?? "Unknown")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                  
                  Spacer()
                      .padding(.horizontal, 5)
                  Button(
                                action: {
                                  createEventinTheCalendar(with: title, forDate: dateBegin, toDate: dateEnd)
                                  showingAlert = true
                                },
                                label: {
                                  HStack(alignment: .firstTextBaseline, spacing: 6) {
                                    Text("Create Event in Apple Calendar")
                                      .foregroundColor(.white)
                                  }
                                  .font(.body.weight(.medium))
                                  .padding(.vertical, 16)
                                  .frame(maxWidth: .infinity)
                                  .clipped()
                                  .foregroundColor(Color(.systemBackground))
                                  .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                      .fill(Color(UIColor.black))
                                  }
                                }
                                )
                  .alert(isPresented: $showingAlert){
                      Alert(title: Text("Success"), message: Text("The event should now be in your default calendar"))
                  }
              }.padding()
              Spacer()
          }
      }
  }
}

func createEventinTheCalendar(
  with title: String, forDate eventStartDate: Date, toDate eventEndDate: Date
) {

  let store = EKEventStore()

  store.requestAccess(to: .event) { (success, error) in
    if error == nil {
      let event = EKEvent.init(eventStore: store)
      event.title = title
      event.calendar = store.defaultCalendarForNewEvents  // this will return deafult calendar from device calendars
      event.startDate = eventStartDate
      event.endDate = eventEndDate

      let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -3600, since: event.startDate))
      event.addAlarm(alarm)

      do {
        try store.save(event, span: .thisEvent)
      } catch let error as NSError {
        print("failed to save event with error : \(error)")
      }

    } else {
      print("error = \(String(describing: error?.localizedDescription))")
    }
  }
}

struct EventDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      EventDetailsView(
      title: "construction du robot", description: "Amenez vos lunettes", dateRawBegin: "4567890", dateRawEnd: "123456789", types: ["FTC", "FRC"],
      id: "354657890", presences: [Present](), absences: [Absent]())
  }
    
}
