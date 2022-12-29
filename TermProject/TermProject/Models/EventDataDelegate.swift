//
//  EventDataDelegate.swift
//  TermProject
//
//  Created by Eren Ceylan on 26.12.2022.
//

import Foundation

protocol EventDataDelegate {
    
    func eventListUpdated()
    
    func eventDetailLoaded(event: Event)

}

extension EventDataDelegate {
    
    func eventListUpdated() {}
    
    func eventDetailLoaded(event: Event) {}

}
