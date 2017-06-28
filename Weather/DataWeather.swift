//
//  DataWeather.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/23/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation

class DataWeather {
    static let shared: DataWeather = DataWeather()
    var searchKey: String = "" {
        didSet {
            guard searchKey != "" else {return}
            updateWeather(searchKey: searchKey)
        }
    }
    private var _currentWeather: CurrentWeather? {
        didSet {
            NotificationCenter.default.post(name: NotificationKey.didUpdateWeather, object: nil)
        }
    }
    
    var currentWeather: CurrentWeather? {
        get{
            if _currentWeather == nil {
                updateWeather(searchKey: "")
            }
            return _currentWeather
        }
        set {
            _currentWeather = newValue
        }
    }

    private var _weatherInFuture: [WeatherInHour]?
    //        didSet {
    //            NotificationCenter.default.post(name: NotificationKey.didUpdateHourOnDay, object: nil)
    //        }
    //    }
    var weatherInFuture : [WeatherInHour] {
        get {
            if _weatherInFuture == nil {
                getCurrentHour()
            }
            return _weatherInFuture ?? []
        }
        
        set {
            _weatherInFuture = newValue
        }
    }
    
    func getCurrentHour(){
        if let timeCurrent = currentWeather?.last_updated_epoch {
            _weatherInFuture = currentWeather?.weatherInWeek[0].weatherInHours.filter{ $0.time_epoch > timeCurrent }
        }
    }
    
    
    func updateWeather(searchKey: String)  {
        let urlWeather = URL(string: "http://api.apixu.com/v1/forecast.json?key=7b98eff561384bf3a8032736172206&q=\(searchKey)&days=7")
        guard let url = urlWeather  else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)  else {
                return
            }
            guard let json = jsonObject as? JSON else {
                return
            }
            guard let weather = CurrentWeather(json: json) else {
                return
            }
            DispatchQueue.main.async {
                self.currentWeather = weather
            }

            
        }
        task.resume()
    }
    
    
}
