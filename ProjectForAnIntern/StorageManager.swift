//
//  StorageManager.swift
//  ProjectForAnIntern
//
//  Created by Artiom Kalinkin on 05.09.2021.
//

import Foundation

class StorageManager {
  enum Const {
    static let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let cachedDateKey = "CachedDate"
  }
  
  struct EmployeesWithDate: Codable {
    let employees: [Employee]
    let date: Date
  }

  func saveEmployees(employees: [Employee]) {
    let employeesWithDate = EmployeesWithDate(employees: employees, date: Date())
    save(data: employeesWithDate)
  }
  
  func loadEmployees() -> [Employee] {
    guard let employeesWithDate: EmployeesWithDate = load()  else { return [] }
    let minute = Calendar.current.dateComponents([.minute], from: employeesWithDate.date, to: Date()).minute
    if let minute = minute, minute < 60 {
      return employeesWithDate.employees
    } else {
      return []
    }
  }

  func save<T: Encodable>(data: T) {
    let path = Const.path
      .appendingPathComponent("\(T.self).json")
    try? JSONEncoder().encode(data).write(to: path)
  }
  
  func load<T: Decodable>() -> T? {
    let path = Const.path
      .appendingPathComponent("\(T.self).json")
    if let data = try? Data(contentsOf: path) {
      return (try? JSONDecoder().decode(T.self, from: data))
    }
    return nil
  }
}
