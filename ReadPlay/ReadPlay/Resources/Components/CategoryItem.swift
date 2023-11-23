//
//  CategoryItem.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CategoryItem: View {
  var category: Category
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 0) {
      
      titleText()
      
      HStack(alignment: .bottom) {
        
        progressBar()
        
        Spacer()
        
        navigateButton()
      }
      
      .padding(.bottom, 14)
      
    }
    .frame(maxWidth: .infinity)
    .frame(height: 100)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(.surface)
    )
    
  }
}

extension CategoryItem {
  
  private func titleText() -> some View {
    return  HStack(spacing: 15) {
      Text("0\(category.categoryId)")
        .customFont(myFont.caption2)
      
      Text("\(category.title)")
        .customFont(myFont.headline3)
      Spacer()
    }
    .padding(15)
    .foregroundStyle(.textBlack)
  }
  
  private func progressBar() -> some View {
    return VStack(alignment: .leading) {
      Text("\(Int(category.progress)) / \(Int(category.totalNum))")
        .customFont(myFont.caption1)
        .foregroundStyle(.gray300)
      ProgressView(value: Double(category.progress), total: Double(category.totalNum))
        .overlay(progressGradient())
        .mask(ProgressView(value: Double(category.progress), total: Double(category.totalNum)))
        .scaleEffect(x: 1, y: 1.4, anchor: .center)
        .frame(width: 100)
    }
    .padding(.leading, 45)
  }
  
  private func navigateButton() -> some View {
    return HStack {
      Text("단어 확인")
      Image(systemName: "chevron.right")
    }
    .padding(.trailing, 15)
    .customFont(myFont.caption1)
    .foregroundStyle(.textBlack)
    
  }
}

//#Preview {
//  CategoryItem(category: .init(category_id: 01, title: "초등 영어 50단어", totalNum: 50, progress: 3))
//}
