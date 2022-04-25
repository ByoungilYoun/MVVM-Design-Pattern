//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by 윤병일 on 2022/04/26.
//

import UIKit

class NewsListTableViewController : UITableViewController {
  
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  //MARK: - Functions
  private func setup() {
    self.navigationController?.navigationBar.prefersLargeTitles = true 
  }
}


