//
//  Ex+Font.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

enum AppFont: String {
  case regular = "Pretendard-Regular"
  case medium = "Pretendard-Medium"
  case semiBold = "Pretendard-SemiBold"
  case bold = "Pretendard-Bold"
}

enum myFont: String, CaseIterable {
  case learningText
  case headline1
  case headline2
  case headline3
  case body1
  case caption1
  case caption2
  case caption3
  
  var fontFamily: String {
    switch self {
    case .learningText: return AppFont.bold.rawValue
    case .headline1: return AppFont.bold.rawValue
    case .headline2: return AppFont.bold.rawValue
    case .headline3: return AppFont.bold.rawValue
    case .body1: return AppFont.bold.rawValue
    case .caption1: return AppFont.semiBold.rawValue
    case .caption2: return AppFont.regular.rawValue
    case .caption3: return AppFont.medium.rawValue
    }
  }
  
  var size: Double {
    switch self {
    case .learningText: return 32
    case .headline1: return 22
    case .headline2: return 20
    case .headline3: return 17
    case .body1: return 14
    case .caption1: return 12
    case .caption2: return 12
    case .caption3: return 14
    }
  }
  
  var lineSpacing: Double {
    switch self {
    case .learningText: return 42
    case .headline1: return 30
    case .headline2: return 24
    case .headline3: return 25.5
    case .body1: return 22
    case .caption1: return 16
    case .caption2: return 16
    case .caption3: return 16
    }
  }
}




/**
폰트 모듈화의 또다른 예시
 
 extension Font {
   static let caption2R: Font = .custom(AppFont.regular.rawValue, size: 11)
 }
 */

