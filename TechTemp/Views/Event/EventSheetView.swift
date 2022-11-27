//
//  EventSheetView.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-29.
//

import SwiftUI
import EventKit
import EventKitUI


struct EventSheetView: View {
    var title: String
    var description: String
    var dateBegin: Date
    var dateEnd: Date
    var types: [String]
    var id: String
    
    @State private var showingAlert = false
    @State private var isPresented = false
    let eventStore = EKEventStore()
    
    
    @Environment(\.dismiss) var dismiss

        var body: some View {
            
            VStack {
                Group {
                    HStack {
                        Text(title)
                            .font(.title)
                            .padding()
                            .padding(.top, 20)
                        Image(systemName: "gearshape.2.fill")
                    }
                    ScrollView(showsIndicators: true){
                        Text(description)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5.0)
                    }
                    .frame(maxWidth: .infinity)
                    Divider()
                    HStack {
                        VStack {
                            Button(action: {
                                isPresented = !isPresented
                            }, label: {
                                HStack(alignment: .firstTextBaseline, spacing: 6) {
                                    Text(isPresented ? "I will am present ✅" : "I will not be present ❌")
                                }
                                .font(.body.weight(.medium))
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .foregroundColor(Color(.systemBackground))
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(isPresented ? Color.green : Color.red)
                                }
                            })
                            
                            
                            Button(action: {
                                createEventinTheCalendar(with: title, forDate: dateBegin, toDate: dateEnd)
                                showingAlert = true
                            }, label: {
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
                            }).alert("The event should now be in your calendar.", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                            
                        }
                        .padding()
                    }
                    Divider()
                    HStack{
                        line()
                            
                        VStack{
                            HStack{
                                Text("From " + dateBegin.formatted())
                                Spacer()
                            }.padding(.horizontal)
                            Spacer()
                            HStack{
                                Text("To " + dateEnd.formatted())
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }.frame(height: 100)
                    
                }
                Group {
                    Spacer()
                }
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color(.displayP3, red: 136/255, green: 184/255, blue: 177/255), Color(UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom)
            }
        }
}

struct line: View{
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 5)
                .overlay {
                    VStack{
                        Circle()
                            .frame(width: 25)
                            .foregroundColor(.gray)
                        Spacer()
                        Circle()
                            .frame(width: 25)
                            .foregroundColor(.gray)
                            .overlay {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 15)
                            }
                    }
                }
        }
        .padding(.leading, 25)
    }
}

func createEventinTheCalendar(with title:String, forDate eventStartDate:Date, toDate eventEndDate:Date) {
    
    let store = EKEventStore()
        
        store.requestAccess(to: .event) { (success, error) in
            if  error == nil {
                let event = EKEvent.init(eventStore: store)
                event.title = title
                event.calendar = store.defaultCalendarForNewEvents // this will return deafult calendar from device calendars
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

struct EventSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EventSheetView(title: "construction du robot", description: "Amenez vos lunettes", dateBegin: Date(), dateEnd: Date(), types: ["FTC", "FRC"], id: "123456789")
    }
}
