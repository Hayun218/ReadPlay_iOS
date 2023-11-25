//
//  VocabListView.swift
//  ReadPlay
//
//  Created by yun on 11/24/23.
//

import SwiftUI

struct VocabListView: View {
  var category: Category
  
  var body: some View {
    var vocabs = Array(category.vocabs) as! [Vocab]
    
    Text(category.title)
    
    ScrollView {
      
      ForEach(vocabs, id: \.self) { vocab in
        Text(vocab.word)
        
      }
    }
  }
}

//#Preview {
//    VocabListView()
//}
