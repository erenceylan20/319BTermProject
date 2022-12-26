//
//  Event.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import Foundation

class Event {
    
    let id: Int
    let hostName: String
    let hostSurname: String
    let title: String
    let beginningTime: Date
    let endingTime: Date
    let place: String
    let detail: String
    let eventType: String
    
    init(id: Int, hostName: String, hostSurname: String, title: String, beginningTime: Date, endingTime: Date, place: String, detail: String, eventType: String) {
        self.id = id
        self.hostName = hostName
        self.hostSurname = hostSurname
        self.title = title
        self.beginningTime = beginningTime
        self.endingTime = endingTime
        self.place = place
        self.detail = detail
        self.eventType = eventType
    }
    
}
