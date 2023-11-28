//
//  CustomButton.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CustomButton: View {
  var text: String
  var icon: String
  
  var body: some View {
    HStack(spacing: 5) {
      Text(text)
        .customFont(.caption1)
      
      Image(systemName: icon)
        .font(.system(size: 18, weight: .bold))
    }
    .padding(.vertical, 7)
    .padding(.leading, 12)
    .padding(.trailing, 6)
    .foregroundStyle(progressGradient())
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(.surface)
    )
  }
}

#Preview {
  CustomButton(text: "단어장 추가", icon: "plus.circle")
}
