//
//  JsonParser.swift
//  ReadPlay
//
//  Created by yun on 11/4/23.
//

import Foundation

func load<T: Decodable>(fileName: String) -> T {
  let data: Data
  
  let extensionType = "json"
  
  // 3. 파일 위치
  guard let file = Bundle.main.url(forResource: fileName, withExtension: extensionType)
  else { fatalError("Couldn't ln file \(fileName)") }
  
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(fileName)")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("decoder part error \(T.self):\n\(error)")
  }
}


