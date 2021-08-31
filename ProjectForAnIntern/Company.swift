//
//  Company.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 30.08.2021.
//

import Foundation

struct Company: Codable {
  let company: Content
}

struct Content: Codable {
  var name: String
  var employees: [Employee]
}

struct Employee: Codable {
  var name: String
  var phone_number: String
  var skills: [String]
}

