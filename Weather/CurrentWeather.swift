//
//  Weather.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/23/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable,Any>
struct CurrentWeather {
    var city: String = ""
    var text: String = ""
    var temp_c: Float = 0.0
    var icon: String = ""
    var last_updated_epoch: TimeInterval
//    var date_epoch: TimeInterval
    var weatherInWeek: [WeatherInWeek] = []
    init?(json: JSON) {
        guard let location = json["location"] as? JSON else {
            return nil}
        let city = location["name"] as? String ?? ""

        guard let current = json["current"] as? JSON else {
            return nil
        }
        let last_updated_epoch = current["last_updated_epoch"] as? TimeInterval ?? 0
        let temp_c = current["temp_c"] as? Float ?? 0
        guard let condition = current["condition"] as? JSON else {
            return nil}
        let text = condition["text"] as? String ?? ""
        let icon = condition["icon"] as? String ?? ""
        
        guard let forecast = json["forecast"] as? JSON else {
            return nil
        }
        guard let forecastdays = forecast["forecastday"] as? [JSON] else {
            return nil
        }
//        var date_epoch: TimeInterval = 0
        for forecastday in forecastdays {
            if let weatherDay = WeatherInWeek(json: forecastday) {
                weatherInWeek.append(weatherDay)
            }

        }
        self.city = city
        self.text = text
        self.temp_c = temp_c
        self.icon = "https:\(icon)"
        self.last_updated_epoch = last_updated_epoch
//        self.date_epoch = date_epoch
    }
    
    //MARK: Private Function

}
