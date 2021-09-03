//
//  Client.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 01.09.2021.
//

import Foundation

enum TableViewError: Error {
  case error(Error)
  case parseError
}

struct Client {
  enum Const {
    static let baseURL = "https://run.mocky.io"
  }
  
  func fetchCompany(completionHandler: @escaping (Result<Company, Error>) -> Void) {
    let url = URL(string: Const.baseURL + "/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")
    let session = URLSession.shared
    session.dataTask(with: url!) {(data, response, error) in
      if let error = error {
        completionHandler(.failure(error))
      } else {
        do {
          let company: Company = try parse(json: data!)
          completionHandler(.success(company))
        } catch {
          completionHandler(.failure(error))
        }
      }
    }.resume()
  }
  
  func fetchEmployers(completionHandler: @escaping (Result<[Employee], Error>) -> Void) {
    fetchCompany(completionHandler: { result in
      completionHandler(result.map({ company in
        company.company.employees
      }))
    })
  }
  
  private func parse<T: Decodable>(json: Data) throws -> T {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: json)
  }
}
