//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/21.
//

import Foundation

extension Double {
  
  func formatAtDegree() -> String {
    return String(format: "%.0f", self)
  }
}
