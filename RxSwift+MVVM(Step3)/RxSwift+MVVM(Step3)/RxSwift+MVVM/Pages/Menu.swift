//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by 윤병일 on 2022/07/05.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation

// ViewModel : View 를 위한 Model
struct Menu {
  var id : Int
  var name : String
  var price : Int
  var count : Int
}

extension Menu {
  static func fromMenuItems(id : Int, item : MenuItem) -> Menu {
    return Menu(id: id, name: item.name, price: item.price, count: 0)
  }
}
