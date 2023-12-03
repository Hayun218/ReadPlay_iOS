//
//  CategoryAddView.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//
import CoreData
import SwiftUI

struct CategoryAddView: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject var addVM = CategoryAddViewModel()
  @StateObject var dataController = DataController.shared
  @Environment(\.managedObjectContext) var managedObjectContext
  @State var newVocabs: [Vocab] = [ ]
  
  init() {
    let newVocab = Vocab(context: managedObjectContext)
    newVocabs.append(newVocab)
    print(newVocabs.count)
  }
  
  let screenHeight = UIScreen.main.bounds.size.height
  
  var body: some View {
    
    VStack {
      VStack {
        appBar
        
        Spacer()
        
        HStack(alignment: .center) {
          
          Image(systemName: "text.justify.left")
            .foregroundStyle(.textWhite)
            .padding(.trailing, 5)
            .padding(.bottom, 3)
          
          VStack(spacing: 6) {
            TextField("", text: $addVM.categoryTitle)
              .placeholder(when: addVM.categoryTitle == "", placeholder: {
                Text("단어장의 이름을 입력하세요")
                  .customFont(.headline3)
                  .foregroundStyle(.textWhite)
                  .opacity(0.8)
              })
              .customFont(.headline3)
              .foregroundStyle(.textWhite)
            
            Divider()
              .frame(height: 1)
              .background(.textWhite)
          }
          .frame(maxWidth: .infinity)
          
          
          Spacer()
          
          Text("\(String(newVocabs.count-1)) 단어")
            .customFont(.caption1)
            .foregroundStyle(.textWhite)
            .padding(.leading, 30)
        }
        
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      .frame(maxWidth: .infinity)
      .frame(height: screenHeight/7)
      
      
      ScrollView {
        ForEach(Array(newVocabs.enumerated()), id: \.element) { idx, new in
          editForm(idx: idx)
        }
      }
    }
    .background(backGradient())
    .interactiveDismissDisabled()
  }
}

extension CategoryAddView {
  
  private var appBar: some View {
    HStack {
      Button(action: { dismiss() }, label: {
        Text("취소")
          .customFont(.body1)
          .foregroundStyle(.textWhite)
      })
      Spacer()
      
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
        Text("작성 완료")
          .customFont(.body1)
          .foregroundStyle(.textWhite)
      })
    }
  }
  
  private func addNewVocabIfNeeded(_ idx: Int) {
    if idx == newVocabs.count - 1 && !newVocabs[idx].word.isEmpty && !newVocabs[idx].meaning.isEmpty {
      DispatchQueue.main.async {
        let newVocab = Vocab(context: managedObjectContext)
        // Set properties for the newVocab instance if needed
        newVocabs.append(newVocab)
      }
    }
  }
  
  private func editForm(idx: Int) -> some View {
    return VStack {
      HStack(alignment: .center) {
        Text("\(idx)")
        
        VStack(spacing: 6) {
          TextField("단어", text: $newVocabs[idx].word)
            .frame(height: 32)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.gray100)
            }
          TextField("뜻", text: $newVocabs[idx].meaning)
            .frame(height: 32)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.gray100)
            }
        }
        .customFont(.body1)
        .foregroundStyle(.textBlack)
        .onChange(of: newVocabs[idx]) { oldValue, newValue in
          addNewVocabIfNeeded(idx)
        }
        
        Button {
          print("remove the idx")
        } label: {
          Image(systemName: "trash")
        }
      }
      .padding(.horizontal, 20)

    }
    .frame(maxWidth: .infinity)
    .frame(height: 94)
    .background(.surface)
  }
  
}

#Preview {
  CategoryAddView()
}
