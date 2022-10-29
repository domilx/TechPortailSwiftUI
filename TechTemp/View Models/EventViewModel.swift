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
    func fetchEventsList(){
        EventService().getHttpEvents(limit: 5, future: false, completion: { (events) in
            self.events = events
        })
    }
}
