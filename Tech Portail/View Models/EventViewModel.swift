//
//  EventViewModel.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-10-14.
//

import Foundation
import SwiftUI

//ObservableObject nous permet de update le UI si qqch change dans le Class
class EventViewModel: ObservableObject {
    //Published marche dans la meme facon que ObservableObject
    @Published var events: Events?
    func fetchEventsList(){
        EventService().getHttpEvents(limit: 5, future: true, completion: { (events) in
            //change la valeure de Published
            self.events = events
        })
    }
}
