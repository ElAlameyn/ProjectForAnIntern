//
//  Company.swift
//  ProjectForAnIntern
//
//  Created by Artiom Kalinkin on 30.08.2021.
//

import Foundation

struct Company: Codable {
  let company: Content
  
  struct Content: Codable {
    let name: String
    let employees: [Employee]
  }
}

struct Employee: Codable {
  let name: String
  let phoneNumber: String
  let skills: [Skill]
  
  enum CodingKeys: String, CodingKey {
    case name, phoneNumber = "phone_number", skills
  }
  
  enum Skill: String, Codable {
    case swift = "Swift"
    case ios = "iOS"
    case kotlin = "Kotlin"
    case android = "Android"
    case objectiveC = "Objective-C"
    case photoshop = "Photoshop"
    case java = "Java"
    case python = "Python"
    case movieMaker = "MovieMaker"
    case groovy = "Groovy"
    case php = "PHP"
    case cSharp = "C#"
  }
}

