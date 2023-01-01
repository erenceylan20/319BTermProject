//
//  Course.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import Foundation


class Course {
    
    
    let id: String
    let title: String
    let code: String
    let beginningTime: Date
    let endingTime: Date
    
    init(id: String, title: String, code: String, beginningTime: Date, endingTime: Date) {
        self.id = id
        self.title = title
        self.code = code
        self.beginningTime = beginningTime
        self.endingTime = endingTime
    }
}
