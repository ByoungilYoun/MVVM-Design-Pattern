//
//  AddOrderViewController.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/04.
//

import UIKit

class AddOrderViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  //MARK: - Properties
  @IBOutlet weak var tableView : UITableView!
  
  private var viewModel = AddCoffeeOrderViewModel()
  
  
  //MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.types.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
    cell.textLabel?.text = self.viewModel.types[indexPath.row]
    return cell
  }
}

