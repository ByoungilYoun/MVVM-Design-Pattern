//
//  WebService.swift
//  OrderCoffeeApp
//
//  Created by 윤병일 on 2022/05/05.
//

import Foundation

struct Resource<T: Codable> {
  let url : URL
  var httpMethod : HTTPMethod = .get
  var body : Data? = nil
  
  init(url : URL) {
    self.url = url
  }
}

enum NetworkError : Error {
  case decodingError
  case domainError
  case urlError
}

enum HTTPMethod : String {
  case get = "GET"
  case post = "POST"
}


class WebService {
  
  static let shared = WebService() 
  
  func load<T>(resource : Resource<T>, completion : @escaping (Result<T, NetworkError>) -> Void) {
    
    URLSession.shared.dataTask(with: resource.url) { data, response, error in
      guard let data = data, error == nil else {
        completion(.failure(.domainError))
        return
      }
      
      let result = try? JSONDecoder().decode(T.self, from: data)
      
      if let result = result {
        DispatchQueue.main.async {
          completion(.success(result))
        }
      } else {
        completion(.failure(.decodingError))
      }
      
    }.resume()
  }
}
  
