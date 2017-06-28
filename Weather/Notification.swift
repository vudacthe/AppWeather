//
//  Notification.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/26/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
struct NotificationKey {
    static let didUpdateWeather = Notification.Name.init("didUpdateWeather")
    static let didUpdateHourOnDay = Notification.Name.init("didUpdateHourOnDay")
}
