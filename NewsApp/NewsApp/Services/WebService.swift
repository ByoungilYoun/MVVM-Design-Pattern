//
//  WebService.swift
//  NewsApp
//
//  Created by 윤병일 on 2022/04/26.
//

import Foundation

struct Article {
  
}

class WebService {
  
  func getArticles(url : URL, completionHandler : @escaping ([Any]?) -> ()) {
    
    URLSession.shared.dataTask(with: url) { data, response, error  in
      if let error = error {
        print(error.localizedDescription)
        completionHandler(nil)
      } else if let data = data {
        print(data)
      }
    }.resume()
  }
}
