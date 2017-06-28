//
//  DaysInWeekTableVC.swift
//  Weather
//
//  Created by Vũ Đắc Thế on 6/24/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import CoreLocation
class DaysInWeekTableVC: UITableViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dayLabel: [UILabel]!
    @IBOutlet var iconImage: [UIImageView]!
    
    @IBOutlet var maxTempLabel: [UILabel]!
    @IBOutlet var minTempLabel: [UILabel]!
    var identifierContry = "VI"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(fillData), name: NotificationKey.didUpdateWeather, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NotificationKey.didUpdateHourOnDay, object: nil)
    }
    

    func fillData() {
        collectionView.reloadData()
        for index in 0..<dayLabel.count {
            guard let day = DataWeather.shared.currentWeather?.weatherInWeek[index + 1].date_epoch
                else {
                    return
            }
            dayLabel[index].text = dayOfWeek(day: day)
            guard let icon = DataWeather.shared.currentWeather?.weatherInWeek[index + 1].iconDay
                else {
                    return
            }
            iconImage[index].dowloadImage(from: icon)
            guard let maxTemp = DataWeather.shared.currentWeather?.weatherInWeek[index + 1].maxtemp_c
                else {
                    return
            }
            maxTempLabel[index].text = "\(maxTemp)ºC"
            guard let minTemp = DataWeather.shared.currentWeather?.weatherInWeek[index + 1].mintemp_c
                else {
                    return
            }
            minTempLabel[index].text = "\(minTemp)ºC"
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Today"
//    }
}
extension DaysInWeekTableVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataWeather.shared.weatherInFuture.count
//        return DataWeather.shared.currentWeather?.weatherInWeek[0].weatherInHours.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherCollectionViewCell
//        if let hour = DataWeather.shared.weatherInFuture[indexPath.row] {
//            collectionCell.hourInDay.text = hourOfDay(hour: hour.time_epoch)
//            collectionCell.imageInDay.dowloadImage(from: hour.icon)
//            collectionCell.temp_cInDay.text = "\(hour.temp_c)ºC"
//        }
        
        let hour = DataWeather.shared.weatherInFuture[indexPath.row]
                collectionCell.hourInDay.text = hourOfDay(hour: hour.time_epoch)
                collectionCell.imageInDay.dowloadImage(from: hour.icon)
                collectionCell.temp_cInDay.text = "\(hour.temp_c)ºC"


//        if let hour = DataWeather.shared.currentWeather?.weatherInWeek[0].weatherInHours[indexPath.row]  {
//            collectionCell.hourInDay.text = hourOfDay(hour: hour.time_epoch)
//            collectionCell.imageInDay.dowloadImage(from: hour.icon)
//            collectionCell.temp_cInDay.text = "\(hour.temp_c)ºC"
//
//        }

//            if indexPath.row == 0 {
//                collectionCell.hourInDay.text = hourOfDay(hour: hour.time_epoch)
//                collectionCell.imageInDay.dowloadImage(from: hour.icon)
//                collectionCell.temp_cInDay.text = "\(hour.temp_c)ºC"
//            }
//            else {
//            let currentHour = DataWeather.shared.weatherInFuture[indexPath.row - 1]
//            collectionCell.hourInDay.text = "\(hourOfDay(hour: currentHour.time_epoch))"
//            collectionCell.imageInDay.dowloadImage(from: currentHour.icon)
//            collectionCell.temp_cInDay.text = "\(currentHour.temp_c)ºC"
//
//            }
//
//        }
        return collectionCell
    }
}
