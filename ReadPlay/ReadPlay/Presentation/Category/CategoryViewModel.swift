//
//  CategoryViewModel.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI
import CoreData

class CategoryViewModel: ObservableObject {
  

  @Published var isAddOn = Bool()

  func addClicked() {
    self.isAddOn.toggle()
  }

  
}

#Preview {
  CategoryView()
}
