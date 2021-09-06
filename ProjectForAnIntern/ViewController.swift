//
//  ViewController.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 30.08.2021.
//

import UIKit

class ViewController: UITableViewController {
  private var filteredEmployees = [Employee]()
  private var client = Client()
  private var storageManager = StorageManager()

  private var tableViewError: Error?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    do {
      filteredEmployees = try storageManager.load()
    } catch {
      print(error.localizedDescription)
    }

    client.fetchEmployers(completionHandler: { [weak self] answer in
      switch answer {
      case .success(let employers):
        self?.filteredEmployees = employers
      case .failure(let error):
        self?.tableViewError = TableViewError.error(error)
      }

      DispatchQueue.main.async {
       self?.tableView.reloadData()
        do {
          try self?.storageManager.save(employers: self?.filteredEmployees ?? []) 
        } catch {
          self?.tableViewError = error
        }
      }
    })
    
    
    
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableViewError != nil && filteredEmployees.isEmpty {
     return 1
    }
    
    return filteredEmployees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableViewError != nil {
      let cell: ErrorCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.errorLabel.text = tableViewError?.localizedDescription
      return cell
    } else {
      let cell: EmployeeCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.fill(employer: filteredEmployees[indexPath.row])
      return cell
    }
  }
}

