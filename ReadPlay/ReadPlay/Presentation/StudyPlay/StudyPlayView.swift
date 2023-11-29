//
//  StudyPlayView.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import SwiftUI

struct StudyPlayView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) var managedObjectContext
  @StateObject var dataController = DataController.shared
  @StateObject var studyPlayVM: StudyPlayViewModel
  
  let screenHeight = UIScreen.main.bounds.size.height
  let fetchedVocabs: Array<Vocab>
  let selectedStatus: VocabStatus
  
  init(fetchedVocabs: [Vocab], selectedStatus: VocabStatus) {
    self.fetchedVocabs = fetchedVocabs
    self.selectedStatus = selectedStatus
    _studyPlayVM = StateObject(wrappedValue: StudyPlayViewModel(vocabs: fetchedVocabs))
  }
  
  var body: some View {
    VStack(alignment: .center) {
      
      backButton
      
      if fetchedVocabs.isEmpty {
        
      } else {
        
        Text(fetchedVocabs[studyPlayVM.wordIdx].word)
          .frame(maxWidth: .infinity)
          .frame(height: screenHeight/2)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .fill(.shadow(.drop(radius: 4)))
              .foregroundColor(.surface)
          )
          .padding(.horizontal, 32)
          .padding(.top, 55)
      }
      
      Spacer()
      
      HStack(alignment: .center) {
        
        Circle()
          .stroke(.clear, lineWidth: 18)
          .frame(width: 40, height: 40)
          .foregroundColor(.clear)
        
        Spacer()
        
        Button(action: { studyPlayVM.stopTimer() }, label: {
          HStack(spacing: 8) {
            Rectangle()
              .frame(width: 12, height: 38)
            Rectangle()
              .frame(width: 12, height: 38)
          }
          .foregroundStyle(.surface)
        })
        .frame(width: 50, height: 50)
        
        Spacer()
        
        Circle()
          .stroke(.surface, lineWidth: 18)
          .frame(width: 40, height: 40)
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
        
      }
      .disabled(fetchedVocabs.isEmpty)
      .padding(.horizontal, 37)
      .padding(.bottom, 50)
    }
    .alert("학습을 완료하였어요.", isPresented: $studyPlayVM.isDone) {
      Button("취소", role: .cancel, action: {})
      
      Button("완료", action: {dismiss()})
      
    } message: {
      Text("축하합니다!")
    }
    
    .background(backGradient())
    .navigationBarBackButtonHidden()
    
    
  }
}
extension StudyPlayView {
  private var backButton: some View {
    HStack {
      Button(action: { dismiss() }, label: {
        Image(systemName: "chevron.backward")
          .font(.system(size: 20))
          .foregroundStyle(.textWhite)
      })
      
      Spacer()
    }
    .padding(.horizontal, 20)
  }
}
