//
//  OrdersTableViewController.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/04.
//

import UIKit

class OrdersTableViewController : UITableViewController {
  
  //MARK: - Properties
  var orderListViewModel = OrderListViewModel()
  
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
    WebService.shared.load(resource: Order.all) { [weak self] result in
      switch result {
      case .success(let orders) :
        self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
        self?.tableView.reloadData()
      case .failure(let error) :
        print(error)
      }
    }
  }
  
  // numberOfSections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  // numberOfRowsInSection
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.orderListViewModel.ordersViewModel.count
  }
  
  // cellForRowAt
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
    cell.textLabel?.text = viewModel.type
    cell.detailTextLabel?.text = viewModel.size
    return cell
  }
}
