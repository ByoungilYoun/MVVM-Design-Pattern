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
  private var coffeeSizesSegmentedControl : UISegmentedControl!
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  //MARK: - Functions
  private func setupUI() {
    self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
    self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(self.coffeeSizesSegmentedControl)
    
    self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
    self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
  }
  
  //MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.types.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
    cell.textLabel?.text = self.viewModel.types[indexPath.row]
    return cell
  }
  
  //MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
  }
  
}

