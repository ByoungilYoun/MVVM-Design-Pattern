//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/20.
//

import Foundation

class WeatherListViewModel {
  private var weatherViewModels = [WeatherViewModel]()
  
  func addWeatherViewModel(_ viewModel : WeatherViewModel) {
    weatherViewModels.append(viewModel)
  }
  
  func numberOfRows(_ section : Int) -> Int {
    return weatherViewModels.count
  }
  
  func modelAt(_ index : Int) -> WeatherViewModel {
    return weatherViewModels[index]
  }
}

class WeatherViewModel {
  
  let weather : WeatherResponse
  
  init(weather : WeatherResponse) {
    self.weather = weather
  }
  
  var city : String {
    return weather.name
  }
  
  var temperature : Double {
    return weather.main.temp
  }
}
