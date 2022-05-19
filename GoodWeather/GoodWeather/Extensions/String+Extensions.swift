//
//  String+Extensions.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/20.
//

import Foundation

extension String {
  
  func escaped() -> String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
  }
}
