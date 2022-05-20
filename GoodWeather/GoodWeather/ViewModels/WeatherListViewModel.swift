//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/20.
//

import Foundation

class WeatherListViewModel {
  
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
