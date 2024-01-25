//
//  StudyPlayViewModel.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import SwiftUI

final class StudyPlayViewModel: ObservableObject {
  let displayedVocabs: [String]
  // 초기 타이머 구현
  @Published var status: Bool = false
  @Published var counter: Int = 3
  var initTimer = Timer()
  
  @Published var wordIdx: Int = 0
  @Published var isDone = Bool()
  @Published var timer: Timer?
  @Published var increasingTimer: Timer?
  @Published var timeInterval: TimeInterval = 1.0
  @Published var isPressing = Bool()
  
  init(vocabs: [String]) {
    self.displayedVocabs = vocabs
    self.startInitTimer()
  }
  
  private func startInitTimer() {
    self.initTimer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true) { _ in
      self.counter -= 1
      //      print(self.counter)
      if(self.counter == 0) {
        self.status = true;
        self.initTimer.invalidate()
        self.startTimer()
      }
    }
  }
  
  func increaseIdx() {
    if self.wordIdx == displayedVocabs.count - 1 {
      self.isDone = true
      stopTimer()
    } else {
      self.wordIdx += 1
    }
  }
  
  func isButtonHeld() {
    print("to True")
    self.isPressing = true
  }
  
  func isButtonReleased() {
    print("to false")
    self.isPressing = false
  }
  
  func startTimer() {
    guard self.timer == nil else {
      return
    }
    
    self.timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true) { _ in
      self.increaseIdx()
      //      print(self.timeInterval)
    }
  }
  
  func startIncreasingTimer() {
    guard self.increasingTimer == nil else {
      return
    }
    self.increasingTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
      self.setUpTimeInterval()
    }
  }
  
  private func setUpTimeInterval() {
    if self.isPressing {
      if self.timeInterval * 0.8 >= 0.15 {
        self.timeInterval *= 0.8
        self.restartTimer()
      }
    } else {
      if self.timeInterval * 1.1 <= 1.0 {
        self.timeInterval *= 1.1
        self.restartTimer()
      }
    }
    
  }
  
  private func restartTimer() {
    self.timer?.invalidate()
    self.timer = nil
    startTimer()
  }
  
  func stopTimer() {
    self.timer?.invalidate()
    self.timer = nil
    self.increasingTimer?.invalidate()
    self.increasingTimer = nil
    self.timeInterval = 1.0
  }
}

