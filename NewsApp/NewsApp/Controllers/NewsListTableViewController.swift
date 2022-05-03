//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by 윤병일 on 2022/04/26.
//

import UIKit

class NewsListTableViewController : UITableViewController {
  
  //MARK: - Properties
  private var aritlceListViewModel : AtricleListViewModel!
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  //MARK: - Functions
  private func setup() {
    self.navigationController?.navigationBar.prefersLargeTitles = true
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0fb3b9d37fd949fc8891ea58dedf4c8b")!
    
    WebService().getArticles(url: url) { articles in
      if let articles = articles {
        self.aritlceListViewModel = AtricleListViewModel(articles: articles)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  // numberOfSections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.aritlceListViewModel == nil ? 0 : self.aritlceListViewModel.numberOfSections
  }
  
  // numberOfRowsInSection
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.aritlceListViewModel.numberOfRowsInSection(section)
  }
  
  // cellForRowAt
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
      fatalError("ArticleTableViewCell not found")
    }
    
    let articleViewModel = self.aritlceListViewModel.articleAtIndex(indexPath.row)
    cell.titleLabel.text = articleViewModel.title
    cell.descriptionLabel.text = articleViewModel.description
    return cell
  }
}


