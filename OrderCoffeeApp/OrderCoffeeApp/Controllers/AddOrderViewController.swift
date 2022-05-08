//
//  AddOrderViewController.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/04.
//

import UIKit

protocol AddCoffeeOrderDelegate {
  func addCoffeeOrderViewControllerDidSave(order : Order, controller : UIViewController)
  func addCoffeeOrderViewControllerDidClose(controller : UIViewController)
}

class AddOrderViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  //MARK: - Properties
  @IBOutlet weak var tableView : UITableView!
  @IBOutlet weak var nameTextField : UITextField!
  @IBOutlet weak var emailTextField : UITextField!
  
  private var viewModel = AddCoffeeOrderViewModel()
  private var coffeeSizesSegmentedControl : UISegmentedControl!
  
  var delegate : AddCoffeeOrderDelegate?
  
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //MARK: - @objc func
  @IBAction func save() {
    let name = self.nameTextField.text
    let email = self.emailTextField.text
    
    let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
    
    guard let indexPath = self.tableView.indexPathForSelectedRow else {
      fatalError("Error in selecting coffee")
    }
    
    self.viewModel.name = name
    self.viewModel.email = email
    
    self.viewModel.selectedSize = selectedSize
    self.viewModel.selectedType = self.viewModel.types[indexPath.row]
    
    WebService().load(resource: Order.create(vm: self.viewModel)) { result in
      switch result {
      case .success(let order) :
        
        if let order = order, let delegate = self.delegate {
          DispatchQueue.main.async {
            delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
          }
        }
        
      case .failure(let error) :
        print(error)
      }
    }
  }
  
  @IBAction func close() {
    if let delegate = self.delegate {
      delegate.addCoffeeOrderViewControllerDidClose(controller: self)
    }
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

