//
//  Ex+View.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

extension View {
  public func backGradient() -> some ShapeStyle {
    LinearGradient(colors: [Color(hex: 0x6B79F6), Color(hex: 0xB1C2FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
  }
  
  public func progressGradient() -> some ShapeStyle {
    LinearGradient(colors: [Color(hex: 0x4A72FF), Color(hex: 0x8D65FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
  }
  
  func customFont(_ fontStyle: myFont) -> some View {
    self
      .font(.custom(fontStyle.fontFamily, size: fontStyle.size))
      .lineSpacing(fontStyle.lineSpacing*0.75)
  }
  
  /// textField Placeholder customize
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
  
}
