//
//  VocabListViewModel.swift
//  ReadPlay
//
//  Created by yun on 11/28/23.
//

import SwiftUI

class VocabListViewModel: ObservableObject {
  
  static let shared = VocabListViewModel()

  @Published var isDeleteAlerttOn = Bool()
  @Published var selectedVocab: Vocab?
  @Published var selectedVocabIdx: Int?
  
  @Published var restore = Bool()
  
  func isDeleteClikced(vocab: Vocab, idx: Int) {
    self.selectedVocab = vocab
    self.selectedVocabIdx = idx-1
    isDeleteAlerttOn.toggle()
  }
  
  func restoreOffset() {
    self.restore.toggle()
  }
  
}
