//
//  VocabListView.swift
//  ReadPlay
//
//  Created by yun on 11/24/23.
//

import SwiftUI

struct VocabListView: View {
  @Environment(\.dismiss) private var dismiss
  var category: Category
  
  var body: some View {
    var vocabs = Array(category.vocabs) as! [Vocab]
    
    VStack {
      HStack {
        Button(action: { dismiss() }, label: {
          Image(systemName: "chevron.backward")
        })
        
        Spacer()
        Text(category.title)
        Spacer()
      }
      
      ScrollView {
        
        ForEach(vocabs, id: \.self) { vocab in
          Text(vocab.word)
          
        }
      }
    }
    .background(backGradient())
    .navigationBarBackButtonHidden(true)
  }
}

//#Preview {
//    VocabListView()
//}
