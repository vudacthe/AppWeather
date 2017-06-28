//
//  ViewController.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/23/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

//    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temp_cLabel: UILabel!
    var identifierCountry = "VI"
    
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerNotification()
        locationManager.delegate = self
        
    }
    
    func fillData() {
        let weather = DataWeather.shared.currentWeather
//        dateLabel.text = "\(weather?.date_epoch ?? 0)"
        temp_cLabel.text = "\(weather?.temp_c ?? 0)ºC"
        cityLabel.text = weather?.city
        weatherImage.dowloadImage(from: (weather?.icon ?? ""))
        conditionLabel.text = weather?.text ?? ""
        
        
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(fillData), name: NotificationKey.didUpdateWeather, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
extension ViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation:CLLocation = locations[0] as CLLocation
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                // City
                if let city = placeMark.addressDictionary?["City"] as? String {
                    let trimmedString = city.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    let cityCurrent = ConverHelper.convertVietNam(trimmedString)
                    DataWeather.shared.searchKey = cityCurrent
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    print(trimmedString)
                }
                
                // Country
                if let country = placeMark.addressDictionary?["Country"] as? NSString {
                    print(country)
                }
                manager.stopUpdatingLocation()
            })
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error \(error)")
        }
}



