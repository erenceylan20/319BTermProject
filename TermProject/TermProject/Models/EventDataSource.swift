//
//  EventDataSource.swift
//  TermProject
//
//  Created by Eren Ceylan on 21.12.2022.
//

import Foundation

class EventDataSource {
    
    private static var eventArray: [Event] = [
        Event(id: 1,
              hostName: "Eren",
              hostSurname: "Ceylan",
              title: "Dinner then coffee",
              beginningTime: Date(),
              endingTime: Date(),
              place: "Omer",
              detail: "We will meet and eat dinner first, then we are gonna drink coffee and chat for a while."),
        Event(id: 2,
              hostName: "Serkan Berk",
              hostSurname: "Bilgiç",
              title: "Football match",
              beginningTime: Date(),
              endingTime: Date(),
              place: "Football Court",
              detail: "We will meet before the game and divide the teams, and after the game, the loser team will buy dinner for the winner time."),
        Event(id: 3,
              hostName: "Gün",
              hostSurname: "Makinabakan",
              title: "Term Project Review",
              beginningTime: Date(),
              endingTime: Date(),
              place: "Engineering B50",
              detail: "In this meeting, we are going to discuss team's current progress, after that you will each get 100 points as your final grade because of your amazing project."),
        Event(id: 4,
              hostName: "Eren",
              hostSurname: "Ceylan",
              title: "Theatre Practice",
              beginningTime: Date(),
              endingTime: Date(),
              place: "Omer -3 Room Theatre",
              detail: "I need 3 people to make practice about a play that I am going to perform at the end of the semester. I would be happy if three of you join my event :)"),
    ]
    //private let baseURL = "https://wizard-world-api.herokuapp.com"
    private var id = 5
    static var delegate: MainViewController?
    
    init() {
    }
    
    
    func getNumberOfEvents() -> Int {
        return EventDataSource.eventArray.count
    }

    
    func getEvent(for index: Int) -> Event? {
        guard index < EventDataSource.eventArray.count else {
            return nil
        }
        
        return EventDataSource.eventArray[index]
    }
    
    func addEvent(event: Event) {
        EventDataSource.eventArray.append(event)
        EventDataSource.delegate?.eventListUpdated()
    }
    
    func setId() -> Int {
        id = id + 1
        return id
    }
    
}
