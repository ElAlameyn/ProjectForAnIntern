//
//  StorageManager.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 05.09.2021.
//

import Foundation

class StorageManager {
  enum Const {
    static let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let fileName = "employers.json"
  }

  func save(employers: [Employee]) throws {
    try JSONEncoder().encode(employers).write(to: Const.path.appendingPathComponent(Const.fileName))
  }
  
  func load() throws -> [Employee] {
    let data = try Data(contentsOf: Const.path.appendingPathComponent(Const.fileName))
    return try JSONDecoder().decode([Employee].self, from: data)
  }
  
}
