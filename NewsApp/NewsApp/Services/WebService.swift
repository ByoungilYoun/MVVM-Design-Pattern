//
//  WebService.swift
//  NewsApp
//
//  Created by 윤병일 on 2022/04/26.
//

import Foundation

class WebService {
  
  func getArticles(url : URL, completionHandler : @escaping ([Article]?) -> ()) {
    
    URLSession.shared.dataTask(with: url) { data, response, error  in
      if let error = error {
        print(error.localizedDescription)
        completionHandler(nil)
      } else if let data = data {
        let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
        
        if let articleList = articleList  {
          completionHandler(articleList.articles)
        }
        
        print(articleList?.articles)
      }
    }.resume()
  }
}
