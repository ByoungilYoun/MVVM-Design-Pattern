//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/10.
//

import UIKit

class AddWeatherCityViewController : UIViewController {
 
  
  //MARK: - Properties
  @IBOutlet weak var cityNameTextField : UITextField!
  
  
  //MARK: - @IBAction
  @IBAction func saveCityButtonPressed() {
    if let city = cityNameTextField.text {
      let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=ca3f00f4a95ffab57dab06a82a990720")!
      
      let weatherResource = Resource<Any>(url: weatherURL) { data in
        return data
      }
      
      WebService().load(resource: weatherResource) { result in
        
      }
    }
  }
  
  @IBAction func close() {
    self.dismiss(animated: true)
  }
}