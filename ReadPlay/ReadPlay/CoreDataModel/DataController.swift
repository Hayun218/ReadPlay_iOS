//
//  DataManager.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//


import CoreData
import SwiftUI

final class DataController: ObservableObject {
  
  static let shared = DataController()
  
  let container: NSPersistentContainer
  let context: NSManagedObjectContext
  
  @Published var fetchedCategories = [Category]() // sink 연습하기,,
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "VocabModel")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    context = container.viewContext
    
    resetCoreData()
    
    fetchCategory()
    if fetchedCategories.isEmpty {
      saveDefaultCategory()
    }
  }
  
  // MARK: - Context 저장
  
  func save(context: NSManagedObjectContext) {
    if context.hasChanges {
      do{
        try context.save()
        print("Data Saved!")
      }catch{
        print("Could not save the data")
      }
    }
  }
  
  // MARK: - DEFAULT CREATE
  
  private func saveDefaultCategory() {
    
    let staticVocab: [StaticVocab] = load(fileName: "elementaryVocab")
    let staticCategory = Category(context: context)
    staticCategory.categoryId = 1
    staticCategory.createdDate = getCurrentDateTime()
    staticCategory.title = "초등 필수 영단어"
    
    for vocab in staticVocab {
      saveVocab(category: staticCategory, wordId: Int32(vocab.word_id), meaning: vocab.meaning, word: vocab.word, context: context)
    }
  }
  
  // MARK: - CREATE
  
  // 전체 카테고리 생성 및 단어리스트 저장
  func saveCategory(categoryId: Int32, title: String, newVocabs: [Vocab], context: NSManagedObjectContext) {
    let category = Category(context: context)
    let newId: Int32 = fetchedCategories.last!.categoryId+1
    category.createdDate = getCurrentDateTime()
    category.categoryId = categoryId
    category.title = title
    
    saveNewCategoryVocabs(newCategory: category, newId: newId, newVocabs: newVocabs, context: context)
  }
  
  // 한 단어 저장
  func saveVocab(category: Category, wordId: Int32, meaning: String, word: String, context: NSManagedObjectContext) {
    let vocab = Vocab(context: context)
    
    vocab.id = wordId
    vocab.meaning = meaning
    vocab.word = word
    vocab.status = 1
    
    category.addToVocabs(vocab)
    
    save(context: context)
  }
  
  private func saveNewCategoryVocabs(newCategory: Category, newId: Int32, newVocabs: [Vocab], context: NSManagedObjectContext) {
    
    newCategory.categoryId = newId
    newCategory.progress = 0
    
    for vocab in newVocabs {
      saveVocab(category: newCategory, wordId: Int32(vocab.id), meaning: vocab.meaning, word: vocab.word, context: context)
    }
  }
  
  // MARK: - READ
  
  func fetchCategory() {
    let request = NSFetchRequest<Category>(entityName: "Category")
    do {
      fetchedCategories = try self.context.fetch(request)
    } catch let error {
      print("error fetching \(error.localizedDescription)")
    }
  }
  
  
  // MARK: - UPDATE
  func updateVocab(vocab: Vocab, meaning: String, word: String, context: NSManagedObjectContext) {
    
    vocab.meaning = meaning
    vocab.word = word
    
    save(context: context)
  }
  
  func updateStatusVocab(vocab: Vocab, status: Int32, context: NSManagedObjectContext) {
    vocab.status = status
    
    updateProgress(category: vocab.category)

    save(context: context)
  }
  
  private func updateProgress(category: Category) {
    let statusPredicate = NSPredicate(format: "status == %@", argumentArray: [3])
    
    let filteredVocabs = category.vocabs.filtered(using: statusPredicate)
    let countOfStatus3 = filteredVocabs.count
    
    category.progress = Int32(countOfStatus3)
    
  }
  
  
  // 카테고리 전체 수정 -> 하면서 하기
  func updateCategory(category: Category, title: String, vocabs: [Vocab], context: NSManagedObjectContext) {
    
    category.title = title
  }
  
  
  // MARK: - DELETE
  
  // 카테고리 전체 삭제
  func deleteCategory(category: Category, context: NSManagedObjectContext) {
    context.delete(category)
    save(context: context)
  }
  
  // 한 단어 삭제
  func deleteVocab(vocab: Vocab, context: NSManagedObjectContext) {
    if vocab.status == 3 {
      vocab.category.progress -= 1
    }
    context.delete(vocab)
    save(context: context)
  }
  
  
  // MARK: - 초기화
  
  func resetCoreData() {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Category")
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try container.viewContext.execute(batchDeleteRequest)
      try container.viewContext.save()
      print("Core Data reset successful.")
    } catch {
      print("Core Data reset failed: \(error.localizedDescription)")
    }
  }
  
  
  // 뷰모델에서 진행,,
  private func getCurrentDateTime() -> String {
    let formatter = DateFormatter() //객체 생성
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    formatter.dateFormat = "yyyy-MM-dd" //데이터 포멧 설정
    let str = formatter.string(from: Date()) //문자열로 바꾸기
    
    return str
  }
}


