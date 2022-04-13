//
//  ViewModel.swift
//  UTCTime
//
//  Created by 윤병일 on 2022/04/13.
//

import Foundation

class ViewModel {
  
  var onUpdated : () -> Void = { }
  
  var dateTimeString : String = "Loading.." // 화면에 보여질 값 // 이게 뷰를 위한 model (viewmodel)
    {
      didSet {
        onUpdated()
      }
    }
  
  let service = Service()
  
  private func dateToString(date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
    return formatter.string(from: date)
  }
  
  func reload() {
    print("하하 여길타나?")
    service.fetchNow { [weak self] model in
      guard let self = self else { return }
      let dateString = self.dateToString(date: model.currentDateTime)
      self.dateTimeString = dateString
    }
  }
  
  func moveDay(day : Int) {
    service.moveDay(day: day)
    dateTimeString = dateToString(date: service.currentModel.currentDateTime)
  }
}
