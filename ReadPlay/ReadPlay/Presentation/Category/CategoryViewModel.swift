//
//  CategoryViewModel.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI
import CoreData

class CategoryViewModel: ObservableObject {
  
  let manager = DataController.shared
  @Published var categories: [Category] = []
  @Published var isAddOn = Bool()
  
  init() {
    self.fetchCategories()
  }
  
  func addClicked() {
    self.isAddOn.toggle()
  }
  
  private func fetchCategories() {
    let request = NSFetchRequest<Category>(entityName: "Category")
    do {
      categories = try manager.context.fetch(request)
      print(categories.first!.vocabs)
    } catch let error {
      print("error fetching \(error.localizedDescription)")
    }
  }
  
  
  
   
  //
  //
  //  // MARK: - 전체 카테고리 생성 및 단어리스트 저장
  //
  //  func saveCategory(categoryId: Int32, title: String, newVocabs: [Vocab]) {
  //    let category = Category(context: container.viewContext)
  //    category.categoryId = categoryId
  //    category.title = title
  //    saveCategoryVocabs(newCategory: category, newVocabs: newVocabs)
  //
  //  }
  //
  //  private func saveCategoryVocabs(newCategory: Category, newVocabs: [Vocab]) {
  //
  //    let newId: Int32 = 2
  //
  //    newCategory.categoryId = newId
  //    newCategory.totalNum = Int32(newVocabs.count)
  //    newCategory.progress = 0
  //    saveContext()
  //
  //    for vocab in newVocabs {
  //      saveVocab(category: newCategory, categoryId: newId, wordId: Int32(vocab.id), meaning: vocab.meaning, word: vocab.word)
  //    }
  //  }
  //
  //
  //  // MARK: - 한 단어 저장
  //
 
  //
  //  func saveOneVocab(category: Category, categoryId: Int32, wordId: Int32, meaning: String, word: String) {
  //    let vocab = Vocab(context: container.viewContext)
  //    vocab.category = category
  //    vocab.id = wordId
  //    vocab.meaning = meaning
  //    vocab.word = word
  //
  //    saveContext()
  //    print("saved a word")
  //  }
  //
  //  func getCurrentDateTime() -> String {
  //    let formatter = DateFormatter() //객체 생성
  //    formatter.dateStyle = .long
  //    formatter.timeStyle = .medium
  //    formatter.dateFormat = "yyyy-MM-dd" //데이터 포멧 설정
  //    let str = formatter.string(from: Date()) //문자열로 바꾸기
  //
  //    return str
  //  }
  //
  //
  //
  //
  //}

  
}

#Preview {
  CategoryView()
}
