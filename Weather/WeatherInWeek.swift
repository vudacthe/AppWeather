//
//  WeatherInWeek.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/24/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
class WeatherInWeek {
    var date_epoch: TimeInterval
    var maxtemp_c: Float
    var mintemp_c: Float
    var iconDay: String
    var weatherInHours: [WeatherInHour] = []
    init?(json: JSON) {
        guard let date_epoch = json["date_epoch"] as? TimeInterval else
        {return nil}
        guard let day = json["day"] as? JSON else
        {return nil}
        let maxtemp_c = day["maxtemp_c"] as? Float ?? 0
        let mintemp_c = day["mintemp_c"] as? Float ?? 0
        
        guard let condition = day["condition"] as? JSON else {return nil}
        let icon = condition["icon"] as? String ?? ""
        
        guard let hours = json["hour"] as? [JSON] else
        { return nil}
        
        for hour in hours {
            if let hourInDay = WeatherInHour(json: hour) {
               weatherInHours.append(hourInDay)
            }
        }
        
        self.date_epoch = date_epoch
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.iconDay = "https:\(icon)"
        
        
    }
}
