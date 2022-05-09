//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/10.
//

import UIKit

class WeatherListTableViewController : UITableViewController {
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
}
