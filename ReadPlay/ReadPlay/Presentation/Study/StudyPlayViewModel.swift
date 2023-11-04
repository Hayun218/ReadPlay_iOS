//
//  StudyPlayViewModel.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import SwiftUI

final class StudyPlayViewModel: ObservableObject {
  @Published var elementaryVocab: [VocabList] = load(fileName: "elementaryVocab")
  @Published var wordIdx: Int = 0
  @Published var isDone = Bool()
  @Published var timer: Timer?
  @Published var timeInterval: TimeInterval = 0.5
  @Published var isPressing = Bool()
  
  func increaseIdx() {
    if self.wordIdx == elementaryVocab.count - 1 {
      self.isDone = true
    } else {
      self.wordIdx += 1
    }
  }
  
  func isButtonTapped() {
    self.isPressing = true
  }
  
  func isButtonUnTapped() {
    self.isPressing = false
  }
  
  func startTimer() {
    
    self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
      self.increaseIdx()
      
      print(self.timeInterval)
      if self.isPressing {
        if self.timeInterval - 0.01 > 0 {
          self.timeInterval -= 0.01
        }
      } else {
        if self.timeInterval < 1.01 {
          self.timeInterval += 0.05
        }
      }
    }
  }
  
  
  func stopTimer() {
    self.timer?.invalidate()
    self.timer = nil
    self.timeInterval = 0.5
  }
}

