//
//  DefaultDataManager.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import Foundation

struct VocabListModel: Hashable, Codable {
  var word_id: Int
  var word: String
  var meaning: String
  
  
  init(word_id: Int, word: String, meaning: String) {
    self.word_id = word_id
    self.word = word
    self.meaning = meaning
  }
}
