//
//  CategoryView.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CategoryView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) var managedObjectContext
  @EnvironmentObject var dataController : DataController
  @StateObject var categoryVM = CategoryViewModel.shared
  @FetchRequest(sortDescriptors: [SortDescriptor(\.categoryId)]) var categories: FetchedResults<Category>
  
  var body: some View {
    
    NavigationStack {
      VStack(alignment: .leading, spacing: 0) {
        
        firstRowTitle()
        
        secondRow()
        
        ScrollView {
          
          ForEach(categories, id: \.self) { category in
            CategoryItem(category: category)
              .environment(\.managedObjectContext, managedObjectContext)
          }
        }
      }
      .padding(.trailing, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(backGradient())
      .sheet(isPresented: $categoryVM.isAddOn, content: {
        CategoryAddView()
          .environment(\.managedObjectContext, dataController.container.viewContext)
      })
      
      // 카테고리 타이틀 수정
      .alert("단어 수정하기", isPresented: $categoryVM.isEditSheetOn) {
        TextField("단어장 타이틀", text: $categoryVM.editedTitle, axis: .vertical)
        Button("취소", role: .cancel, action: { categoryVM.restoreOffsetToggle() })
        Button("확인") {
          dataController.updateCategoryTitle(category: categoryVM.selectedCategory!, title: categoryVM.editedTitle, context: managedObjectContext)
          categoryVM.restoreOffsetToggle()
          dismiss()
        }
      }
    
      .alert("단어장이 삭제됩니다", isPresented: $categoryVM.isDeleteAlertOn, actions: {
        Button {
          if let category = categoryVM.selectedCategory {
            dataController.deleteCategory(category: category, context: managedObjectContext)
          }
        } label: {
          Text("삭제")
        }
        Button(role: .cancel, action: {}, label: {
          Text("취소")
        })
      }, message: {
        Text("삭제된 단어장은\n복원되지 않습니다")
      })
    }
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
    .padding(.leading, 20)
    .foregroundStyle(.textWhite)
  }
  
  private func secondRow() -> some View {
    return HStack {
      Image(systemName: "list.bullet")
      Text("\(dataController.fetchedCategories.count)개의 단어장")
      Spacer()
      
      if dataController.isForUser {
        CustomButton(text: "단어장 추가", icon: "plus.circle")
          .onTapGesture {
            categoryVM.addClicked()
          }
      }
    }
    .customFont(.caption3)
    .foregroundStyle(.textWhite)
    .padding(.bottom, 12)
    .padding(.leading, 20)
  }
}

#Preview {
  CategoryView()
}
