//
//  ShowTime.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/26.
//

import Foundation

struct ShowTimesContainerInfo: Codable {
    let showtimes: [ShowTimesInfo]
}

struct ShowTimesInfo: Codable {
    let day: String
    let date: String
    let theaters: [TheaterInfo]
}

struct TheaterInfo: Codable {
    let name: String
    let link: String
    let showing: [ShowingInfo]
}

struct ShowingInfo: Codable {
    let time: [String]
}

class TransformShowTime {
    let day: String
    let date: String
    let theaters: [TheaterInfo]
    var isSelected: Bool = false
    
    init(day: String, date: String, isSelected: Bool, theaters: [TheaterInfo]) {
        self.day = day
        self.date = date
        self.isSelected = isSelected
        self.theaters = theaters
    }
}
