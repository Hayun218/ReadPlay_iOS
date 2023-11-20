//
//  CategoryView.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CategoryView: View {
  
  @StateObject var categoryVM = CategoryViewModel()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      firstRowTitle()
      
      secondRow()
      
      ScrollView {
        
        // 전체가 onTapGesture로 액션!
        CategoryItem(category: .init(category_id: 1, title: "here", totalNum: 500, progress: 40))
      }
      
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(backGradient())
    .fullScreenCover(isPresented: $categoryVM.isAddOn, content: {
      CategoryAddView()
    })
    
    
  }
}

extension CategoryView {
  private func firstRowTitle() -> some View {
    return HStack {
      Text("Read Play")
        .customFont(.headline1)
      
      Spacer()
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
        Image(systemName: "gearshape")
          .font(.system(size: 22))
      })
    }
    .padding(.vertical, 25)
    .foregroundStyle(.textWhite)
  }
  
  private func secondRow() -> some View {
    return HStack {
      Image(systemName: "list.bullet")
      Text("22개의 단어장")
      Spacer()
      CustomButton(text: "단어장 추가", icon: "plus.circle")
        .onTapGesture {
          categoryVM.addClicked()
        }
    }
    .customFont(.caption3)
    .foregroundStyle(.textWhite)
    .padding(.bottom, 12)
  }
}

#Preview {
  CategoryView()
}
