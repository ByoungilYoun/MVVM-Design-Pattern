//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by 윤병일 on 2022/05/10.
//

import UIKit

class WeatherListTableViewController : UITableViewController {
  
  //MARK: - Properties
  private var weatherListViewModel = WeatherListViewModel()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddWeatherCityViewController" {
      prepareSegueForWeatherCityViewController(segue: segue)
    }
  }
  
  private func prepareSegueForWeatherCityViewController(segue : UIStoryboardSegue) {
    guard let nav = segue.destination as? UINavigationController else {
      fatalError("NavigationController not found")
    }
    
    guard let addWeatherCityViewController = nav.viewControllers.first as? AddWeatherCityViewController else {
      fatalError("AddWeatherCityController not found")
    }
    
    addWeatherCityViewController.delegate = self
  }
  //MARK: - numberOfSections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //MARK: - numberOfRowsInSection
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherListViewModel.numberOfRows(section)
  }
  
  //MARK: - cellForRowAt
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
    
    let weatherViewModel = weatherListViewModel.modelAt(indexPath.row)
    cell.configure(weatherViewModel)
    return cell
  }
  
  //MARK: - heightForRowAt
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

  //MARK: - Extension AddWeatherDelegate
extension WeatherListTableViewController : AddWeatherDelegate {
  func addWeatherDidSave(viewModel: WeatherViewModel) {
    weatherListViewModel.addWeatherViewModel(viewModel)
    self.tableView.reloadData()
  }
}
