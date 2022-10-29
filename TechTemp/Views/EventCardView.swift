//
//  EventCardView.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-20.
//

import SwiftUI

struct EventCardView: View {
    @Binding var event: Event
    
    var body: some View {
        VStack{
            Text(event.name ?? "nil")
            //for each presents in event

        }
    }
}
