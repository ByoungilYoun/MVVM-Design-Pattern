//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/19.
//

import Foundation

struct WeatherResponse : Decodable {
  let main : Weather
}

struct Weather : Decodable {
  let temp : Double
  let humidity : Double
}
