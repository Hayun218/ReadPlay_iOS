//
//  CategoryItem.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct VocabItem: View {
  @StateObject var dataController = DataController.shared
  
  @State private var offset: CGFloat = 0
  @StateObject var vocabVM = VocabListViewModel.shared
  @GestureState private var gestureOffset: CGFloat = 0
  @State private var showOpt = Bool()
  @State var vocabModifier: String = ""
  
  let offsetWidth = UIScreen.main.bounds.size.width/2.5
  
  @State var vocab: Vocab
  let vocabId: Int
  
  init(vocab: Vocab, vocabId: Int) {
    self._vocab = State(initialValue: vocab)
    self.vocabId = vocabId
  }
  
  init(vocab: Vocab) {
    self._vocab = State(initialValue: vocab)
    self.vocabId = Int(_vocab.wrappedValue.id)
  }
  
  
  var body: some View {
    
    VStack(alignment: .center) {
      
      HStack(alignment: .top, spacing: 0) {
        
        vocabNumText
        
        vocabContent
        
        Spacer()
        
        statusButton
      }
      
      Divider()
        .frame(height: 1)
        .background(.grayLine)
    }
    .frame(maxWidth: .infinity)
    .frame(height: 86)
    
    .background(
      Rectangle()
        .foregroundStyle(.surface)
    )
    .offset(x: offset)
    .gesture(swipeGesture)
    
    .onAppear {
      if vocab.id != Int32(vocabId) {
        vocab.id = Int32(vocabId)
        dataController.save(context: dataController.context)
      }
      
      if vocabId < 10 {
        vocabModifier = "00"
      } else if vocabId < 100 {
        vocabModifier = "0"
      } else {
        vocabModifier = ""
      }
    }
 
    
    .overlay(
      showOpt ?
      HStack(spacing: 0) {
        editButton()
        deleteButton()
      }
        .offset(x: offsetWidth - offsetWidth/4)
        .frame(width: offsetWidth)
        .frame(height: 86)
      
      : nil
    )
    .onChange(of: vocabVM.restore, { _, _ in
      self.showOpt = false
      self.offset = 0
    })
   
  }
}

extension VocabItem {
  
  private var statusButton: some View {
    
    VStack {
      Spacer()
      
      Button {
        vocab.status = Int32(vocabVM.updateStatus(vocab: vocab))
        dataController.save(context: dataController.context)
      } label: {
        Circle()
          .stroke(.gray200, lineWidth: 1.4)
          .overlay(
            Circle()
              .fill(VocabStatus(rawValue: Int(vocab.status))!.buttonColor)
              .frame(width: 14, height: 14)
          )
          .frame(width: 26, height: 26)
      }
      
      Spacer()
    }
    .padding(.trailing, 29)
  }
  
  private var vocabNumText: some View {
    Text("\(vocabModifier)\(vocabId)")
      .customFont(.caption1)
      .foregroundStyle(.gray300)
      .padding(.horizontal, 20)
      .padding(.top, 15)
  }
  
  private var vocabContent: some View {
    VStack(alignment: .leading, spacing: 3) {
      Text(vocab.word)
        .customFont(.headline2)
        .foregroundStyle(.textBlack)
      Text(vocab.meaning)
        .customFont(.body1)
        .foregroundStyle(.gray300)
    }
    .padding(.top, 24)
  }
  
  private var swipeGesture: some Gesture {
    DragGesture()
      .updating($gestureOffset) { value, state, _ in
        state = value.translation.width
      }
      .onChanged { value in
        withAnimation {
          offset = value.translation.width + gestureOffset
        }
      }
      .onEnded { value in
        let finalOffset = value.translation.width + gestureOffset
        withAnimation {
          if finalOffset < -offsetWidth {
            offset = -offsetWidth
            showOpt = true
          } else {
            offset = 0
            showOpt = false
          }
        }
      }
  }
  
  private func deleteButton() -> some View {
    return Button(action: { vocabVM.isDeleteClikced(vocab: vocab, idx: vocabId) }, label: {
      Image(systemName: "trash")
        .font(.system(size: 20))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
          Rectangle()
            .foregroundStyle(.redButton)
        )
    })
  }
  
  private func editButton() -> some View {
    return Button(action: { print("offset: \(offset) , offsetWidth: \(offsetWidth)") }, label: {
      Image(systemName: "pencil")
        .font(.system(size: 20))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
          Rectangle()
            .foregroundStyle(.greenButton)
        )
    })
  }
}

//#Preview {
//  CategoryItem(category: .init(category_id: 01, title: "초등 영어 50단어", totalNum: 50, progress: 3))
//}
