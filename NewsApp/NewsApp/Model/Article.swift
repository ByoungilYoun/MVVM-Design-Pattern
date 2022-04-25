//
//  Article.swift
//  NewsApp
//
//  Created by 윤병일 on 2022/04/26.
//

import Foundation

struct ArticleList : Decodable {
  let articles : [Articles]
}

struct Articles : Decodable {
  let title : String
  let description : String
}
