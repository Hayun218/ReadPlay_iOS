//
//  VocabStatus.swift
//  ReadPlay
//
//  Created by yun on 11/28/23.
//

import SwiftUI

enum StudyOpt: Int, CaseIterable {
  case word = 1
  case meaning = 2
  case all = 3

  
  var studyOptWord: String {
    switch self {
    case .word : "단어 학습"
    case .meaning: "뜻 학습"
    case .all: "동시 학습"
    }
  }
}
