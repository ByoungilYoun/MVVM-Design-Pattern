//
//  WeatherTableViewCell.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/10.
//

import UIKit

class WeatherTableViewCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "WeatherCell"
  
  @IBOutlet weak var cityNameLabel : UILabel!
  @IBOutlet weak var temperatureLabel : UILabel!
  
  
}
