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
  
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "VocabModel")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    context = container.viewContext
    
    resetCoreData()
    
    saveDefaultCategory()
  }
  
  func saveContext() {
    let context = container.viewContext
    if context.hasChanges {
      do {
        try context.save()
        print("Data Saved!")
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  
  func saveDefaultCategory() {
    
    let staticVocab: [StaticVocab] = load(fileName: "elementaryVocab")
    let staticCategory = Category(context: context)
    staticCategory.categoryId = 1
    staticCategory.title = "초등 필수 영단어"
    staticCategory.totalNum = Int32(staticVocab.count)
    
    for vocab in staticVocab {
      //      let vocabData = Vocab(context: context)
      //      
      //      vocabData.id = Int32(vocab.word_id)
      //      vocabData.meaning = vocab.meaning
      //      vocabData.word = vocab.word
      //      
      //      staticCategory.addToVocabs(vocabData)
      saveVocab(category: staticCategory, wordId: Int32(vocab.word_id), meaning: vocab.meaning, word: vocab.meaning)
    }
    
    saveContext()
    
    print(staticCategory.vocabs.count)
    
  }
  
  func saveVocab(category: Category, wordId: Int32, meaning: String, word: String) {
    let vocab = Vocab(context: context)
    
    vocab.id = wordId
    vocab.meaning = meaning
    vocab.word = word
    
    category.addToVocabs(vocab)
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
}


//
