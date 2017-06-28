//
//  WeatherInHour.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/23/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation

class WeatherInHour {
    var time_epoch: TimeInterval
    var temp_c: Float
    var icon: String
    init?(json: JSON) {
        guard let time_epoch = json["time_epoch"] as? TimeInterval else {
            return nil
        }
        let temp_c = json["temp_c"] as? Float ?? 0
        guard let condition = json["condition"] as? JSON else {
            return nil
        }
        let icon = condition["icon"] as? String ?? ""
        
        self.time_epoch = time_epoch
        self.temp_c = temp_c
        self.icon = "https:\(icon)"
    }
}
