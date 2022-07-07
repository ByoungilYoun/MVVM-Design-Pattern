//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 윤병일 on 2022/07/05.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class MenuListViewModel {
  
  //MARK: - Property
  lazy var menuObservable = BehaviorSubject<[Menu]>(value: [])
  
  lazy var itemsCount = menuObservable.map {
    $0.map { $0.count }.reduce(0, +)
  } // 총 선택된 아이템 갯수
  
  lazy var totalPrice = menuObservable.map {
    $0.map { $0.price * $0.count }.reduce(0, +)
  } // 총 가격
  
  
  //MARK: - Init
  init() {
    let menus : [Menu] = [
      Menu(id : 0, name: "튀김1", price: 100, count: 0),
      Menu(id : 1, name: "튀김1", price: 100, count: 0),
      Menu(id : 2, name: "튀김1", price: 100, count: 0),
      Menu(id : 3, name: "튀김1", price: 100, count: 0)
    ]
    
    menuObservable.onNext(menus)
  }
  
  //MARK: - Functions
  
  func order() {
    
  }
  
  func clearAllItemSelections() {
    _ = menuObservable
      .map { menus in
        return menus.map { m in
          Menu(id : m.id, name: m.name, price: m.price, count: 0)
        }
      }
      .take(1)
      .subscribe(onNext: {
        self.menuObservable.onNext($0)
      })
  }
  
  func changeCount(item : Menu, increase : Int) {
    _ = menuObservable
      .map { menus in
        return menus.map { m in
          if m.id == item.id {
            return Menu(id : m.id, name: m.name, price: m.price, count: max(m.count + increase, 0))
          } else {
            return Menu(id : m.id, name: m.name, price: m.price, count: m.count)
          }
        }
      }
      .take(1)
      .subscribe(onNext: {
        self.menuObservable.onNext($0)
      })
  }
}
