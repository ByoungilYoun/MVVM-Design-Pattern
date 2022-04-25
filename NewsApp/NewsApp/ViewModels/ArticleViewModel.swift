//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by 윤병일 on 2022/04/26.
//

import Foundation

struct AtricleListViewModel {
  let articles : [Article]
  
  var numberOfSections : Int {
    return 1
  }
  
  func numberOfRowsInSection(_ section : Int) -> Int {
    return self.articles.count
  }
  
  func articleAtIndex(_ index : Int) -> ArticleViewModel {
    let article = self.articles[index]
    return ArticleViewModel(article)
  }
}


struct ArticleViewModel {
  
  //MARK: - Properties
  private let article : Article
  
  var title : String {
    return self.article.title
  }
  
  var description : String {
    return self.article.description
  }
  
  //MARK: - Init
  init(_ article : Article) {
    self.article = article
  }
  
  
}

