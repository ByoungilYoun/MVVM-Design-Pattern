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
  
  //MARK: - numberOfSections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //MARK: - numberOfRowsInSection
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  //MARK: - cellForRowAt
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
    cell.cityNameLabel.text = "Huston"
    cell.temperatureLabel.text = "70°"
    return cell
  }
  
  //MARK: - heightForRowAt
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
