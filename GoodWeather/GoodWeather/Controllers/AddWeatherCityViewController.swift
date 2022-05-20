//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/10.
//

import UIKit

protocol AddWeatherDelegate {
  func addWeatherDidSave(viewModel : WeatherViewModel)
}

class AddWeatherCityViewController : UIViewController {
 
  
  //MARK: - Properties
  @IBOutlet weak var cityNameTextField : UITextField!
  
  private var addWeatherViewModel = AddWeatherViewModel()
  
  var delegate : AddWeatherDelegate?
  
  //MARK: - @IBAction
  @IBAction func saveCityButtonPressed() {
    
    if let city = cityNameTextField.text {
      addWeatherViewModel.addWeather(for: city) { viewModel in
        self.delegate?.addWeatherDidSave(viewModel: viewModel)
        self.dismiss(animated: true)
      }
    }
  }
  
  @IBAction func close() {
    self.dismiss(animated: true)
  }
}
