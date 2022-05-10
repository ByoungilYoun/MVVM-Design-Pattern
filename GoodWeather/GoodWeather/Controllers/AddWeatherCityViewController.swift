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
    
  }
  
  @IBAction func close() {
    self.dismiss(animated: true)
  }
}
