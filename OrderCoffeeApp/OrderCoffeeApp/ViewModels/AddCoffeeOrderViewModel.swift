//
//  AddCoffeeOrderViewModel.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/06.
//

import Foundation

struct AddCoffeeOrderViewModel {
  
  //MARK: - Properties
  var name : String?
  var email : String?
  
  var selectedType : String?
  var selectedSize : String?
  
  var types : [String] {
    return CoffeeType.allCases.map { $0.rawValue.capitalized }
  }
  
  var sizes : [String] {
    return CoffeeSize.allCases.map { $0.rawValue.capitalized }
  }
}
