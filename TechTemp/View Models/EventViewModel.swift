//
//  EventViewModel.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-14.
//

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: Events?
    func fetchEventsList(isFuture: Bool, limit: Int){
        EventService().getHttpEvents(limit: limit, future: isFuture, completion: { (events) in
            self.events = events
        })
    }
}
