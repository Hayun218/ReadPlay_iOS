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
  @State var newVocabs: [StaticVocab] = [.init(word_id: 0, word: "", meaning: ""), ]
  
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
        LazyVStack(spacing: 0) {
          ForEach(newVocabs.indices, id: \.self) { idx in
            editForm(idx: idx)
          }
          Text("단어를 연속해서 입력하세요")
            .customFont(.body1)
            .foregroundStyle(.textWhite)
            .padding(.top, 40)
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
    if idx == newVocabs.count - 1 && newVocabs[idx].word != "" && newVocabs[idx].meaning != "" {
      newVocabs.append(.init(word_id: newVocabs.count-1, word: "", meaning: ""))
      
    }
  }
  
  private func editForm(idx: Int) -> some View {
    let wordBinding = Binding<String>(
      get: { newVocabs[idx].word },
      set: { newValue in
        newVocabs[idx].word = newValue
        if newVocabs.count-1 == idx {
          addNewVocabIfNeeded(idx)
        }
      }
    )
    
    let meaningBinding = Binding<String>(
      get: { newVocabs[idx].meaning },
      set: { newValue in
        newVocabs[idx].meaning = newValue
        if newVocabs.count-1 == idx {
          addNewVocabIfNeeded(idx)
        }
      }
    )
    
    return VStack(alignment: .center, spacing: 0) {
      HStack(alignment: .center) {
        Text("\(idx)")
        
        VStack(spacing: 6) {
          
          TextField("단어",  text: wordBinding)
            .frame(height: 32)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.gray100)
            }
          TextField("뜻",  text: meaningBinding)
            .frame(height: 32)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.gray100)
            }
        }
        .customFont(.body1)
        .foregroundStyle(.textBlack)
        .padding(.leading, 20)
        .padding(.trailing, 40)
        .padding(.vertical, 12)
        
        Button {
          print("remove the idx")
        } label: {
          Image(systemName: "trash")
            .font(.system(size: 20))
            .foregroundStyle(.redButton)
        }
      }
      .padding(.horizontal, 20)
      
      Divider()
        .frame(height: 1)
        .background(.gray300)
      
    }
    .frame(maxWidth: .infinity)
    .frame(height: 94)
    .background(.surface)
  }
  
}

#Preview {
  CategoryAddView()
}
