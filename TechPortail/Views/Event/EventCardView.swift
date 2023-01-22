//
//  EventCardView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-10-20.
//
import Foundation
import SwiftUI

struct EventCardView: View {
    var title: String
    var description: String
    var dateRawBegin: String
    var dateRawEnd: String
    var types: [String]
    var id: String
    var presences: [Present]?
    var absences: [Absent]
    
    @AppStorage("userId") var userId: String = "null"

    @State private var isPresent = false
    @State private var hasRegistered = false
    @State private var color: Color = Color.green
    @State private var showingSheet = false
    
    var body: some View {
        
        let dateBegin: Date? = returnDate(date: dateRawBegin)
        let dateEnd: Date? = returnDate(date: dateRawEnd)
        HStack(alignment: .top, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    .onAppear {
                      for presence in presences! {
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
                    Spacer()
                    Text(dateBegin?.formatted() ?? "nil").foregroundColor(.secondary)
                    Image(systemName: "chevron.right").foregroundColor(.secondary)
                }
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Badge(text: "\(presences!.count)", imageName: "person.fill")
                        .foregroundColor(.teal)
                    
                    if(isPresent){
                        Badge(text: "Present", imageName: "person.fill.checkmark")
                            .padding(.leading, 75)
                            .foregroundColor(.green)
                    }
                    if(!isPresent && hasRegistered){
                        Badge(text: "Absent", imageName: "person.fill.xmark")
                            .padding(.leading, 75)
                            .foregroundColor(.red)
                    }
                    if(!isPresent && !hasRegistered){
                        Badge(text: "Not registered", imageName: "person.fill.questionmark")
                            .padding(.leading, 75)
                            .foregroundColor(Color("yellow"))
                    }
                    
                    HStack{
                        Image(systemName: "gear")
                        ForEach(types, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .onAppear{
                        if(types.count == 2){
                            color = Color.orange
                        }
                        else if(types.contains("FRC") && types.count == 1){
                            color = Color.purple
                        }
                        else if(types.contains("FTC") && types.count == 1){
                            color = Color.mint
                        }
                    }
                    .foregroundColor(color)
                    .padding(.leading, 225)
                }
                .font(.callout)
                
            }
        }
        .padding(.top, 16.0)
    }
}
struct Badge: View {
    let text: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}

struct Position: View {
    let position: Image
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(.teal)
            Text("\(position)")
                .font(.callout)
                .bold()
                .foregroundColor(.white)
        }
    }
}

func returnDate(date: String) -> Date? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter.date(from: date)
    
}


