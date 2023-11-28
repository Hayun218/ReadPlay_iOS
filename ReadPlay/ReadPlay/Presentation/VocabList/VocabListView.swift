//
//  VocabListView.swift
//  ReadPlay
//
//  Created by yun on 11/24/23.
//

import SwiftUI

struct VocabListView: View {
  var category: Category
  
  @Environment(\.dismiss) private var dismiss
  @StateObject var dataController = DataController.shared
  @StateObject var vocabVM = VocabListViewModel.shared
  
  @State var vocabs: [Vocab]
  
  let screenHeight = UIScreen.main.bounds.size.height
  
  init(category : Category) {
    self.category = category
    let allVocabs = category.vocabs.allObjects as? [Vocab] ?? []
    self._vocabs = State(initialValue: allVocabs.sorted(by: { $0.id < $1.id }))
  }
  
  var body: some View {
    
    VStack {
      
      VStack {
        tabBar
        
        Spacer()
        
        HStack(alignment: .center) {
          
          Text("\(vocabs.count)개 단어\n생성일: \(category.createdDate)")
            .customFont(.caption1)
            .foregroundStyle(.textWhite)
          
          Spacer()
          
          CustomButton(text: "학습하기", icon: "play.circle")
        }
        
        HStack {
          
        }
        
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      .frame(maxWidth: .infinity)
      .frame(height: screenHeight/4.8)
      
      ScrollView {
        LazyVStack(spacing: 0) {
          
          ForEach(Array(zip(vocabs.indices, vocabs)), id: \.0) { index, vocab in
            VocabItem(vocab: vocab, vocabId: index + 1)
          }
        }
      }
    }
    .alert("단어가 삭제됩니다", isPresented: $vocabVM.isDeleteAlerttOn, actions: {
      Button {
        if let vocab = vocabVM.selectedVocab {
          dataController.deleteVocab(vocab: vocab, context: dataController.container.viewContext)
          self.vocabs.remove(at: vocabVM.selectedVocabIdx!)
          vocabVM.restoreOffset()
        }
      } label: {
        Text("삭제")
      }
      Button(role: .cancel, action: {}, label: {
        Text("취소")
      })
    }, message: {
      Text("삭제된 단어는 복원되지 않습니다")
    })
    .background(backGradient())
    .navigationBarBackButtonHidden()
  }
}

extension VocabListView {
  private var tabBar: some View {
    HStack {
      Button(action: { dismiss() }, label: {
        Image(systemName: "chevron.backward")
          .font(.system(size: 20))
          .foregroundStyle(.textWhite)
      })
      
      Spacer()
      Text(category.title)
        .customFont(.headline2)
        .foregroundColor(.textWhite)
      Spacer()
    }
  }
}

//#Preview {
//    VocabListView()
//}
