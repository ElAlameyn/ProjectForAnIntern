//
//  ViewController.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 30.08.2021.
//

import UIKit

// tomorrow work
enum TableViewError: Error {
  case error(Error)
  case parseError
}

class ViewController: UITableViewController {
  var filteredEmployees = [Employee]()
  var isFailed = false
  
  private var error: Error?

  override func viewDidLoad() {
    super.viewDidLoad()

    let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c_"
    let url = URL(string: urlString)

    let session = URLSession.shared
    session.dataTask(with: url!) { [weak self] (data, response, error) in
      if error == nil, let data = data {
        if let company: Company = self?.parse(json: data) {
          self?.filteredEmployees = company.company.employees
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
        } else {
          self?.isFailed = true
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
        }
      } else {
        self?.isFailed = true
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      }
    }.resume()
  }
  
  func showError() {
    let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading a feed.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  private func parse<T: Decodable>(json: Data) -> T? {
    let decoder = JSONDecoder()
    if let parsedStruct = try? decoder.decode(T.self, from: json) {
      return parsedStruct
    }
    return nil
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFailed && filteredEmployees.isEmpty {
     return 1
    }
    return filteredEmployees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isFailed {
      let cell: ErrorCell = tableView.dequeueReusableCell(indexPath: indexPath)
      return cell
    } else {
      let cell: EmployeeCell = tableView.dequeueReusableCell(indexPath: indexPath)
      let employee = filteredEmployees[indexPath.row]
      cell.backgroundColor = .white
      cell.nameLabel.text = employee.name
      cell.telephoneLabel.text = "Tel: \(employee.phone_number)"
      cell.firstSkillLabel.text = employee.skills.first ?? ""
      cell.secondSkillLabel.text = employee.skills[employee.skills.index(0, offsetBy: 1)]
      return cell
    }
  }
}

