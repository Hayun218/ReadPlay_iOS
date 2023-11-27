//
//  CategoryViewModel.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI
import CoreData

class CategoryViewModel: ObservableObject {
  
  static let shared = CategoryViewModel()
  
  @Environment(\.managedObjectContext) var managedObjectContext
  @Published var isAddOn = Bool()
  @Published var selectedCategory: Category? = nil
  @Published var isDeleteAlertOn = Bool()
  @Published var isEditSheetOn = Bool()
  
  func addClicked() {
    self.isAddOn.toggle()
  }
  
  func isEditClicked(category: Category) {
    selectedCategory = category
    isEditSheetOn.toggle()
  }
  
  func isDeleteClicked(category: Category) {
    selectedCategory = category
    isDeleteAlertOn.toggle()
  }
}

#Preview {
  CategoryView()
}
