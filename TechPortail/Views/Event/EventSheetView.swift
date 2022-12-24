//
//  EventSheetView.swift
//  TechPortail
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
  var dateRawBegin: String
  var dateRawEnd: String
  var types: [String]
  var id: String
  var presences: [Present]?
  var absences: [Absent]

  @AppStorage("userId") var userId: String = "null"

  @State private var showingAlert = false
  @State private var isPresent = false
  @State private var hasRegistered = false
  let eventStore = EKEventStore()
  @State private var color = Color.yellow

  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack {
      Group {
              Text("Pull up for more info")
                      .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 10)
                .padding(.bottom, 10)
              .padding(.top, 20)
        HStack {
          Text(title)
                .font(.title)
                  .fontWeight(.bold)
            .padding(.horizontal, 20)
            
          Image(systemName: "gearshape.2.fill")
            .onAppear {
              for (presence) in presences! {
                if presence.user?.id == userId {
                  isPresent = true
                }
              }
            }
        }
        ScrollView(showsIndicators: true) {
          Text(description)
            .padding(.horizontal, 10)
            .padding(.vertical, 5.0)
            peoplePresent(presences: presences!, absences: absences)
        }
        .frame(maxWidth: .infinity)
        Divider()
        HStack {
          VStack {
            Button(
              action: {
                if !isPresent {
                  PresenceService().putPresence(
                    debut: dateRawBegin, fin: dateRawEnd, event: id,
                    completion: { isGood in
                      isPresent = isGood
                      print(isPresent)
                    })
                }
                if isPresent {
                  AbsenceService().putAbsence(
                    event: id,
                    completion: { bool in
                      isPresent = bool
                      print(isPresent)

                    })
                }
              },
              label: {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                  if isPresent {
                    Text("You are currently registered as present ✅")
                      .onAppear {
                        color = Color.green
                      }
                  }
                  if !hasRegistered && !isPresent {
                    Text("You are not registered yet")
                      .onAppear {
                        color = Color.yellow
                      }
                  }
                  if hasRegistered && !isPresent {
                    Text("You are currently registered as absent ❌")
                      .onAppear {
                        color = Color.red
                      }
                  }
                }
                .font(.body.weight(.medium))
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .clipped()
                .foregroundColor(Color(.systemBackground))
                .background {
                  RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(color)
                }
              }
            )
            .onAppear {
              for presence in presences! {
                if presence.user?.id! == userId {
                  self.isPresent = true
                  self.hasRegistered = true
                } else {
                  self.hasRegistered = false
                }
              }
              for absence in absences {
                if absence.user?.id == userId {
                  self.isPresent = false
                  self.hasRegistered = true
                } else {
                  self.hasRegistered = false
                }
              }
            }

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
            ).alert("The event should now be in your calendar.", isPresented: $showingAlert) {
              Button("OK", role: .cancel) {}
            }

          }
          .padding()
        }
        Divider()
        HStack {
          line()

          VStack {
            HStack {
              Text("From " + dateBegin.formatted())
              Spacer()
            }.padding(.horizontal)
            Spacer()
            HStack {
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
      LinearGradient(
        gradient: Gradient(colors: [
          Color(.displayP3, red: 136 / 255, green: 184 / 255, blue: 177 / 255),
          Color(UIColor.systemBackground),
        ]), startPoint: .top, endPoint: .bottom)
    }
  }
}

struct line: View {
  var body: some View {
    VStack {
      Rectangle()
        .foregroundColor(.gray)
        .frame(width: 5)
        .overlay {
          VStack {
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

struct peoplePresent: View {
  var presences: [Present]
  var absences: [Absent]
  var body: some View {
    VStack {
      HStack {
        Text("People Present")
          .font(.title)
          .padding(.horizontal)
      }
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(presences, id: \.id) { presence in
            VStack {
              Image(systemName: "person.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
              Text(presence.user?.name! ?? "nil")
            }.padding(.horizontal, 5)
              .padding(.vertical, 10)
          }
        }
      }
    }
    HStack{
      Text("People Absent")
        .font(.title)
        .padding(.horizontal)
    }
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(absences, id: \.id) { absence in
          VStack {
            Image(systemName: "person.fill")
              .resizable()
              .frame(width: 50, height: 50)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 4))
            Text(absence.user?.name! ?? "nil")
          }.padding(.horizontal, 5)
            .padding(.vertical, 10)
        }
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

struct EventSheetView_Previews: PreviewProvider {
  static var previews: some View {
    EventSheetView(
      title: "construction du robot", description: "Amenez vos lunettes", dateBegin: Date(),
      dateEnd: Date(), dateRawBegin: "4567890", dateRawEnd: "123456789", types: ["FTC", "FRC"],
      id: "354657890", absences: [Absent]())
  }
}
