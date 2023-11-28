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
  @Published var selectedStatus: VocabStatus = .all
  @Published var restore = Bool()
  
  @Published var status: Int = 1
  
  func updateStatus(vocab: Vocab) -> Int {
    status = Int(vocab.status)
    if vocab.status + 1 > 3 {
      self.status = 1
      vocab.status = 1
    } else {
      self.status += 1
    }
    return self.status
  }
  
  
  func selectStatus(status: VocabStatus) {
    self.selectedStatus = status
  }
  
  func isDeleteClikced(vocab: Vocab, idx: Int) {
    selectedVocab = vocab
    isDeleteAlerttOn.toggle()
  }
  
  func restoreOffset() {
    self.restore.toggle()
  }
  
}
