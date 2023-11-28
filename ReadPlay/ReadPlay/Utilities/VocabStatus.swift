//
//  VocabStatus.swift
//  ReadPlay
//
//  Created by yun on 11/28/23.
//

import SwiftUI

enum VocabStatus: Int {
  case yellow = 1
  case red = 2
  case green = 3
  
  
  var buttonColor: Color {
    switch self {
    case .yellow: Color(.yellowDot)
    case .red: Color(.redButton)
    case .green: Color(.greenDot)
      
    }
  }
}
