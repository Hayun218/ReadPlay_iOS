//
//  CategoryAddView.swift
//  ReadPlay
//
//  Created by yun on 11/20/23.
//

import SwiftUI

struct CategoryAddView: View {
  @Environment(\.dismiss) private var dismiss
  
    var body: some View {
      Button(action: {dismiss()}, label: {
        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
      })
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CategoryAddView()
}
