//
//  CategoryView.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CategoryView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  //  @StateObject var dataController = DataController.shared
  @EnvironmentObject var dataController : DataController
  @StateObject var categoryVM = CategoryViewModel()
  @FetchRequest(sortDescriptors: [SortDescriptor(\.categoryId)]) var categories: FetchedResults<Category>
  
  
  var body: some View {
    
    NavigationStack {
      VStack(alignment: .leading, spacing: 0) {
        
        firstRowTitle()
        
        secondRow()
        
        ScrollView {
          
          
          ForEach(categories, id: \.self) { category in
            NavigationLink(destination: VocabListView(category: category)) {
              CategoryItem(category: category)
            }
          }
        }
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(backGradient())
      .sheet(isPresented: $categoryVM.isAddOn, content: {
        CategoryAddView()
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
