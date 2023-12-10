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
  var image: String = ""
  
  @State var vocab: Vocab
  let vocabId: Int
  
  init(vocab: Vocab, vocabId: Int) {
    self._vocab = State(initialValue: vocab)
    self.vocabId = vocabId
    self.image = "\(_vocab.wrappedValue.category.categoryId)_\(_vocab.wrappedValue.word)_img"
  }
  
  init(vocab: Vocab) {
    self._vocab = State(initialValue: vocab)
    self.vocabId = Int(_vocab.wrappedValue.id)
    self.image = "\(_vocab.wrappedValue.category.categoryId)_\(_vocab.wrappedValue.word)_img"
  }
  
  
  var body: some View {
    
    VStack(alignment: .center) {
      
      HStack(alignment: .center, spacing: 0) {
        
        vocabNumText
        
        if let image = UIImage(named: image) {
          
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
            .padding(.leading, 20)
            .padding(.top, 10)
        }
        
        vocabContent
          .padding(.leading, 20)
        
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
        dataController.updateStatusVocab(vocab: vocab, status: Int32(vocabVM.updateStatus(vocab: vocab)), context: dataController.context)
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
    .padding(.top, 14)
  }
  
  private var vocabNumText: some View {
    
    VStack {
      Text("\(vocabModifier)\(vocabId)")
        .customFont(.caption1)
        .foregroundStyle(.gray300)
        .padding(.leading, 20)
        .padding(.top, 15)
      
      Spacer()
    }
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
    .padding(.top, 14)
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
    return Button(action: { vocabVM.isDeleteClikced(vocab: vocab) }, label: {
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
    return Button(action: { vocabVM.isEditClicked(vocab: vocab) }, label: {
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
