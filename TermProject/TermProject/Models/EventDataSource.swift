//
//  EventDataSource.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import Foundation

class EventDataSource {
    
    private var eventArray: [Event] = []
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    
    init() {
        
        eventArray = [
            Event(id: 1,
                  hostName: "Eren",
                  hostSurname: "Ceylan",
                  title: "Dinner then coffee",
                  beginningTime: Date(),
                  endingTime: Date(),
                  place: "Omer",
                  detail: "We will meet and eat dinner first, then we are gonna drink coffee and chat for a while"),
            Event(id: 2,
                  hostName: "Serkan Berk",
                  hostSurname: "Bilgiç",
                  title: "Football match",
                  beginningTime: Date(),
                  endingTime: Date(),
                  place: "Football Court",
                  detail: "We will meet before the game and divide the teams, and after the game, the loser team will buy dinner for the winner time")
        ]
    }
    
    
    func getNumberOfEvents() -> Int {
        return eventArray.count
    }

    
    func getEvent(for index: Int) -> Event? {
        guard index < eventArray.count else {
            return nil
        }
        
        return eventArray[index]
    }
    
}
