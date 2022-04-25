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
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0fb3b9d37fd949fc8891ea58dedf4c8b")!
    WebService().getArticles(url: url) { _ in
      
    }
  }
  
  //MARK: - Functions
  private func setup() {
    self.navigationController?.navigationBar.prefersLargeTitles = true 
  }
}


