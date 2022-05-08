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
  
  // prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navC = segue.destination as? UINavigationController,
          let addCoffeeOrderViewController = navC.viewControllers.first as? AddOrderViewController else {
      fatalError("Error performing segue")
    }
    
    addCoffeeOrderViewController.delegate = self
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

//MARK: - AddCoffeeOrderDelegate

extension OrdersTableViewController : AddCoffeeOrderDelegate {
  func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
    controller.dismiss(animated: true)
    
    let orderViewModel = OrderViewModel(order: order)
    self.orderListViewModel.ordersViewModel.append(orderViewModel)
    self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
  }
  
  func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
    controller.dismiss(animated: true)
  }
}
