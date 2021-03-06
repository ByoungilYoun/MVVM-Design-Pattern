//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
  
  //MARK: - Property
  let cellId = "MenuItemTableViewCell"
  
  let viewModel = MenuListViewModel()
  
  var disposeBag = DisposeBag()
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var itemCountLabel: UILabel!
  @IBOutlet var totalPrice: UILabel!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.menuObservable
      .observeOn(MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: MenuItemTableViewCell.self)) { index, item, cell in
        cell.title.text = item.name
        cell.price.text = "\(item.price)"
        cell.count.text = "\(item.count)"
        
        cell.onChange = { [weak self] increase in
          self?.viewModel.changeCount(item: item, increase: increase)
        }
      }.disposed(by: disposeBag)
    
    viewModel.itemsCount
      .map { "\($0)" }
      .asDriver(onErrorJustReturn: "")
      .drive(itemCountLabel.rx.text)
//      .bind(to: itemCountLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.totalPrice
      .map { $0.currencyKR() }
      .bind(to: totalPrice.rx.text)
      .disposed(by: disposeBag)
  }
  
  //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //        let identifier = segue.identifier ?? ""
  //        if identifier == "OrderViewController",
  //            let orderVC = segue.destination as? OrderViewController {
  //            // TODO: pass selected menus
  //        }
  //    }
  
  //    func showAlert(_ title: String, _ message: String) {
  //        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
  //        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
  //        present(alertVC, animated: true, completion: nil)
  //    }
  
  //MARK: - @IBAction
  
  @IBAction func onClear() {
    viewModel.clearAllItemSelections()
  }
  
  @IBAction func onOrder(_ sender: UIButton) {
    // TODO: no selection
    // showAlert("Order Fail", "No Orders")
    //        performSegue(withIdentifier: "OrderViewController", sender: nil)
    viewModel.order()
  }
}
