//
//  CategoryItem.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CategoryItem: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @State private var offset: CGFloat = 0
  @StateObject var categoryVM = CategoryViewModel.shared
  @GestureState private var gestureOffset: CGFloat = 0
  @State private var showOpt = Bool()
  
  let offsetWidth = UIScreen.main.bounds.size.width/3
  
  var category: Category
  
  var body: some View {
    
    NavigationLink {
      VocabListView(category: category)
        .environment(\.managedObjectContext, managedObjectContext)
      
    } label: {
      
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
        RoundedRectangle(cornerRadius: 10)
          .foregroundStyle(.surface)
      )
      .padding(.leading, showOpt ? 0 : 20)
      .offset(x: offset)
      .gesture(swipeGesture)
    }
    .overlay(
      showOpt ?
      HStack(spacing: 0) {
        editButton()
        deleteButton()
      }
        .offset(x: offsetWidth-10)
        .frame(maxWidth: offsetWidth-5, alignment: .trailing)
        .frame(height: 100)
      
      : nil
    )
  }
}

extension CategoryItem {
  
  private var swipeGesture: some Gesture {
    DragGesture()
      .updating($gestureOffset) { value, state, _ in
        state = value.translation.width
      }
      .onChanged { value in
        withAnimation {
          offset = value.translation.width + gestureOffset
        }
      }
      .onEnded { value in
        let finalOffset = value.translation.width + gestureOffset
        withAnimation {
          if finalOffset < -offsetWidth {
            offset = -offsetWidth
            showOpt = true
          } else {
            offset = 0
            showOpt = false
          }
        }
      }
  }
  
  private func deleteButton() -> some View {
    return Button(action: { categoryVM.isDeleteClicked(category: category) }, label: {
      Image(systemName: "trash")
        .font(.system(size: 20))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.redButton)
        )
        .padding(.leading, 3)
    })
  }
  
  private func editButton() -> some View {
    return Button(action: { categoryVM.isEditClicked(category: category) }, label: {
      Image(systemName: "pencil")
        .font(.system(size: 20))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.greenButton)
        )
        .padding(.horizontal, 3)
    })
  }
  
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
      Text("\(Int(category.progress)) / \(Int(category.vocabs.count))")
        .customFont(myFont.caption1)
        .foregroundStyle(.gray300)
      ProgressView(value: Double(category.progress), total: Double(category.vocabs.count))
        .overlay(progressGradient())
        .mask(ProgressView(value: Double(category.progress), total: Double(category.vocabs.count)))
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
