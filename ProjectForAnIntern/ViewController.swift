//
//  ViewController.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 30.08.2021.
//

import UIKit

class ViewController: UITableViewController {
  var employees = [Employee]()
  var filteredEmployees = [Employee]()
  var isFailed = false

  override func viewDidLoad() {
    super.viewDidLoad()

    let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    let url = URL(string: urlString)

    let session = URLSession.shared
      let dataTask: Void = session.dataTask(with: url!) { [weak self] (data, response, error) in
      if error == nil, let data = data {
        // Ошибка error company nil? в одной cell красный бэк
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    if isFailed {
      cell.textLabel?.text = "List is empty"
      cell.detailTextLabel?.text = "Failed to load list."
      cell.backgroundColor = .red
      return cell
    }
    
    let employee = filteredEmployees[indexPath.row]
    cell.backgroundColor = .white
    cell.textLabel?.text = employee.name + " phone: " + String(employee.phone_number)
    cell.detailTextLabel?.text = "Skills: \(employee.skills)"
    return cell
  }
}

