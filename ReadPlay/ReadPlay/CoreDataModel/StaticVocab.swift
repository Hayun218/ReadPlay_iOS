//
//  StaticVocab.swift
//  ReadPlay
//
//  Created by yun on 11/21/23.
//

import Foundation

struct StaticVocab: Hashable, Codable {
  var word_id: Int
  var word: String
  var meaning: String
 
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.word_id = try container.decode(Int.self, forKey: .word_id)
    self.word = try container.decode(String.self, forKey: .word)
    self.meaning = try container.decode(String.self, forKey: .meaning)
  }
  
}
