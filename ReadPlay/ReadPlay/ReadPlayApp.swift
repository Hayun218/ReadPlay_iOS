//
//  ReadPlayApp.swift
//  ReadPlay
//
//  Created by yun on 10/25/23.
//

import SwiftUI

@main
struct ReadPlayApp: App {
  
  @StateObject var dataController : DataController
  
  init() {
    let dataController = DataController()
    _dataController = StateObject(wrappedValue: dataController)
  }
  
  
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
