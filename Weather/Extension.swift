//
//  Extension.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/23/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func dowloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
}
extension DaysInWeekTableVC {
    func dayOfWeek(day: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: day)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: identifierContry)
        let dayVI = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        return dayVI
    }
    
    func hourOfDay(hour: TimeInterval) -> String {
        let hour = Date(timeIntervalSince1970: hour)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: identifierContry)
        dateFormatter.timeStyle = .short
        let hourVI = dateFormatter.string(from: hour)
        return hourVI
    }
}
