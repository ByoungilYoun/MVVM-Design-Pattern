//
//  Entity.swift
//  UTCTime
//
//  Created by 윤병일 on 2022/04/13.
//

import Foundation

struct UtcTimeModel : Decodable {
  let id : String
  let currentDateTime : String
  let utcOffset : String
  let isDayLightSavingsTime : Bool
  let dayOfTheWeek : String
  let timeZoneName : String
  let currentFileTime : Int
  let ordinalDate : String
  let serviceResponse : String?
  
  enum CodingKeys : String, CodingKey {
    case id = "$id"
    case currentDateTime
    case utcOffset
    case isDayLightSavingsTime
    case dayOfTheWeek
    case timeZoneName
    case currentFileTime
    case ordinalDate
    case serviceResponse
  }
}
