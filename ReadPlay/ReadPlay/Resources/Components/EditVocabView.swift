//
//  EditVocabView.swift
//  ReadPlay
//
//  Created by yun on 11/29/23.
//

import SwiftUI

struct EditVocabView: View {
    var vocab: Vocab
  
  @State private var word = ""
  @State private var meaning = ""
  
  init(vocab: Vocab) {
    self.vocab = vocab
    self.word = vocab.word
    self.meaning = vocab.meaning
  }
  
  var body: some View {
    Form {
      Section(header: Text("단어 수정하기")) {
        TextField("단어", text: $word)
        TextField("뜻", text: $meaning)
      }
    }
  }
}

//#Preview {
//  EditVocabView()
//}
