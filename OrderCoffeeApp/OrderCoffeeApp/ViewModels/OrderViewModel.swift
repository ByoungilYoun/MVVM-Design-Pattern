//
//  OrderViewModel.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/06.
//

import Foundation

class OrderListViewModel {
  
  //MARK: - Properties
  var ordersViewModel : [OrderViewModel]
  
  //MARK: - init
  init() {
    self.ordersViewModel = [OrderViewModel]()
  }
  
  //MARK: - Functions
  func orderViewModel(at index : Int) -> OrderViewModel {
    return self.ordersViewModel[index]
  }
}

struct OrderViewModel {
  
  //MARK: - Properties
  let order : Order
  
  var name : String {
    return self.order.name
  }
  
  var email : String {
    return self.order.email
  }
  
  var type : String {
    return self.order.type.rawValue.capitalized
  }
  
  var size : String {
    return self.order.size.rawValue.capitalized
  }
}

