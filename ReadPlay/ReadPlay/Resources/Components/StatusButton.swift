//
//  StatusButton.swift
//  ReadPlay
//
//  Created by yun on 11/28/23.
//

import SwiftUI

struct StatusButton: View {
  let status: VocabStatus
  var isSelected: Bool
  
    var body: some View {
      HStack {
        if status != .all {
          Circle()
            .foregroundStyle(status.buttonColor)
            .frame(width: 11, height: 11)
        }
        
        Text(status.buttonLabel)
          .customFont(.caption1)
          .foregroundStyle(isSelected ? .gray300 : .textWhite)
      }
      .padding(.vertical, 4)
      .padding(.horizontal, 12)
      .background(
        RoundedRectangle(cornerRadius: 4)
          .fill(isSelected ? .surface : .clear)
          .stroke(isSelected ? .gray200 : .gray100, lineWidth: 1)
      )
    }
}

#Preview {
  StatusButton(status: .all, isSelected: true)
}
