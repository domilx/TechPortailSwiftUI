//
//  EventCardView.swift
//  TechTemp
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
    
    @State private var showingSheet = false
    
    var body: some View {
        
        let dateBegin: Date? = returnDate(date: dateRawBegin)
        let dateEnd: Date? = returnDate(date: dateRawEnd)
        VStack{
            HStack( spacing: 6) {
                Text(title)
                    .fontWeight(.bold)
                Spacer()
                Capsule(style: .continuous)
                    .foregroundColor(Color(.secondaryLabel))
                    .frame(width: 60, height: 30)
                    .clipped()
                    .overlay{
                        Text(types.first ?? "nil")
                    }
            }
            Divider()
            HStack{
                Text(description)
                Spacer()
            }
            HStack{
                Spacer()
                Text("See details").underline(true)
                Image(systemName: "arrow.right.circle.fill")
            }
        }
        .font(.body.weight(.medium))
        .foregroundColor(Color("primary"))
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .clipped()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill( Color(.displayP3, red: 28/255, green: 131/255, blue: 119/255))
                .addBorder(Color(.displayP3, red: 136/255, green: 184/255, blue: 177/255), width: 5, cornerRadius: 15)
                //.stroke(Color(.displayP3, red: 136/255, green: 184/255, blue: 177/255), lineWidth: 4)
            
        }
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            EventSheetView(title: title, description: description, dateBegin: dateBegin!, dateEnd: dateEnd!, types: types, id: id)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.automatic)
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

func returnDate(date: String) -> Date? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter.date(from: date)
    
}
