//
//  VocabStatus.swift
//  ReadPlay
//
//  Created by yun on 11/28/23.
//

import SwiftUI

enum VocabStatus: Int, CaseIterable {
  case all = 0
  case yellow = 1
  case red = 2
  case green = 3
  
  
  var buttonColor: Color {
    switch self {
    case .all: Color(.clear)
    case .yellow: Color(.yellowDot)
    case .red: Color(.redButton)
    case .green: Color(.greenDot)
    }
  }
  
  var buttonLabel: String {
    switch self {
    case .all: "전체 단어"
    case .yellow: "학습중"
    case .red: "헷갈림"
    case .green: "암기완료"
    }
  }
}
