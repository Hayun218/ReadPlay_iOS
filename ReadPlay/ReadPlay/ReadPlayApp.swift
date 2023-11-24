//
//  ReadPlayApp.swift
//  ReadPlay
//
//  Created by yun on 10/25/23.
//

import SwiftUI

@main
struct ReadPlayApp: App {
  
  let dataController = DataController.shared
  
  var body: some Scene {
    WindowGroup {
      NavigationStack() {
        CategoryView()
          .environment(\.managedObjectContext, dataController.container.viewContext)
          .environmentObject(dataController)
      }
    }
  }
}
