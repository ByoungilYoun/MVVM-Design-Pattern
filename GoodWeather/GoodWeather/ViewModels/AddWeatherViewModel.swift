//
//  AddWeatherViewModel.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/20.
//

import Foundation

class AddWeatherViewModel {
  
  func addWeather(for city : String, @escaping (WeatherViewModel) -> Void) {
    
    let weatherURL = Constants.Urls.urlForWeatherByCity(city: city)
    
    let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data in
      let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
      return weatherResponse
    }
    
    WebService().load(resource: weatherResource) { result in
      
      if let weatherResource = result {
          let viewModel = WeatherViewModel(weatherResource)
          completion(viewModel)
      }
    }
  }
  
}
