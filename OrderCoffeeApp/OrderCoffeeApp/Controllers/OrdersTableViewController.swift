//
//  OrdersTableViewController.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/04.
//

import UIKit

class OrdersTableViewController : UITableViewController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.populateOrders()
  }
  
  //MARK: - Functions
  private func configureUI() {
    
  }
  
  private func populateOrders() {
    guard let coffeeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
      fatalError("URL was incorrect")
    }
    
    let resource = Resource<[Order]>(url: coffeeOrdersURL)
    
    WebService.shared.load(resource: resource) { result in
      switch result {
      case .success(let orders) :
        print(orders)
      case .failure(let error) :
        print(error)
      }
    }
  }
}
