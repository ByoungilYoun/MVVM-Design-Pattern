//
//  Constants.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/20.
//

import Foundation

struct Constants {

  struct Urls {
      static func urlForWeatherByCity(city : String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=ca3f00f4a95ffab57dab06a82a990720&units=imperial")!
    }
  }
}
