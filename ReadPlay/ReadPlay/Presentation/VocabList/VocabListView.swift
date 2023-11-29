//
//  VocabListView.swift
//  ReadPlay
//
//  Created by yun on 11/24/23.
//
import CoreData
import SwiftUI

struct VocabListView: View {
  var category: Category
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) var managedObjectContext
  @StateObject var dataController = DataController.shared
  @StateObject var vocabVM = VocabListViewModel.shared
  @FetchRequest var fetchedVocabs: FetchedResults<Vocab>
  
  let screenHeight = UIScreen.main.bounds.size.height
  
  init(category : Category) {
    
    self.category = category
    let request: NSFetchRequest<Vocab> = Vocab.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Vocab.id, ascending: true)]
    request.predicate = NSPredicate(format: "category == %@", category)
    
    self._fetchedVocabs = FetchRequest(fetchRequest: request)
  }
  
  var body: some View {
    
    VStack {
      
      VStack {
        tabBar
        
        Spacer()
        
        HStack(alignment: .center) {
          
          Text("\(fetchedVocabs.count)개 단어\n생성일: - \(category.createdDate)")
            .lineSpacing(-0.3)
            .customFont(.caption1)
            .foregroundStyle(.textWhite)
          
          Spacer()
          
          NavigationLink {
            if vocabVM.selectedStatus == .all {
              StudyPlayView(fetchedVocabs: Array(fetchedVocabs), selectedStatus: vocabVM.selectedStatus)
            } else {
              let filteredVocabs = fetchedVocabs.filter {$0.status == vocabVM.selectedStatus.rawValue}
              StudyPlayView(fetchedVocabs: filteredVocabs, selectedStatus: vocabVM.selectedStatus)
            }
          } label: {
            CustomButton(text: "학습하기", icon: "play.circle")
          }

         
        }
        .padding(.bottom, 20)
        
        statusButton()
        
        
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      .frame(maxWidth: .infinity)
      .frame(height: screenHeight/5)
      
      ScrollView {
        LazyVStack(spacing: 0) {
          
          if vocabVM.selectedStatus == .all {
            ForEach(Array(fetchedVocabs.enumerated()), id: \.element) { idx, vocab in
              VocabItem(vocab: vocab, vocabId: idx + 1)
            }
          } else {
            ForEach(fetchedVocabs.filter {$0.status == vocabVM.selectedStatus.rawValue}, id: \.self) { vocab in
              VocabItem(vocab: vocab)
            }
          }
        }
      }
    }
    // 단어 수정
    .alert("단어 수정하기", isPresented: $vocabVM.isEditOn) {
      TextField("단어", text: $vocabVM.editedWord)
      TextField("뜻", text: $vocabVM.editedMeaning)
      Button("취소", role: .cancel, action: { vocabVM.restoreOffset() })
      Button("확인") {
        dataController.updateVocab(vocab: vocabVM.selectedVocab!, meaning: vocabVM.editedMeaning, word: vocabVM.editedWord, context: managedObjectContext)
        vocabVM.restoreOffset()
      }
    }
    
    // 단어 삭제 알림
    .alert("단어가 삭제됩니다", isPresented: $vocabVM.isDeleteAlerttOn, actions: {
      Button {
        if let vocab = vocabVM.selectedVocab {
          dataController.deleteVocab(vocab: vocab, context: managedObjectContext)
          vocabVM.restoreOffset()
        }
      } label: {
        Text("삭제")
      }
      Button(role: .cancel, action: {}) {
        Text("취소")
      }
    }, message: {
      Text("삭제된 단어는 복원되지 않습니다")
    })
    .onAppear {
      vocabVM.restoreOffset()
    }
    .background(backGradient())
    .navigationBarBackButtonHidden()
  }
}

extension VocabListView {
  
  private func statusButton() -> some View {
    return HStack {
      ForEach(VocabStatus.allCases, id: \.rawValue) { statusCase in
        Button(action: { vocabVM.selectStatus(status: statusCase) }, label: {
          StatusButton(status: statusCase, isSelected: vocabVM.selectedStatus == statusCase)
        })
        if statusCase != .green {
          Spacer()
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
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
