//
//  StudyPlayView.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import SwiftUI

struct StudyPlayView: View {
  @StateObject var studyPlayVM = StudyPlayViewModel()
  
  var body: some View {
    VStack {
      
      Text(studyPlayVM.elementaryVocab[studyPlayVM.wordIdx].word)
        .font(.subheadline)
        .padding(30)
      
      Spacer()
      
      HStack {
        
        Spacer()
        
        Button(action: { studyPlayVM.stopTimer() }, label: {
          Text("STOP")
        })
        
        
        Circle()
          .frame(width: 100, height: 100)
          .foregroundStyle(.yellow)
          .gesture(
            DragGesture(minimumDistance: 0)
              .onChanged{ _ in
                  studyPlayVM.isButtonHeld()
                  studyPlayVM.startTimer()
                  studyPlayVM.startIncreasingTimer()
              }
              .onEnded { _ in
                studyPlayVM.isButtonReleased()
              }
          )
          .padding(30)
      }
    }
    
    
    
  }
}

#Preview {
  StudyPlayView()
}
