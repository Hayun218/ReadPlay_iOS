//
//  DefaultDataManager.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import Foundation

struct CategoryModel: Hashable, Codable {
  var category_id: Int
  var title: String
  var totalNum: Double
  var progress: Double
  
  
  init(category_id: Int, title: String, totalNum: Double, progress: Double) {
    self.category_id = category_id
    self.title = title
    self.totalNum = totalNum
    self.progress = progress
  }
}
