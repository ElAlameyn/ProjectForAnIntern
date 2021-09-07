//
//  ViewController.swift
//  ProjectForAnIntern
//
//  Created by Artiom Kalinkin on 30.08.2021.
//

import UIKit

class ViewController: UITableViewController {
  private var employees = [Employee]()
  private var client = Client()
  private var storageManager = StorageManager()

  private var tableViewError: Error?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    employees = storageManager.loadEmployees()

    client.fetchEmployees(completionHandler: { [weak self] answer in
      switch answer {
      case .success(let employees):
        let sortedEmployees = employees.sorted(by: {$0.name < $1.name})
        self?.employees = sortedEmployees
        self?.storageManager.saveEmployees(employees: sortedEmployees)
      case .failure(let error):
        self?.tableViewError = TableViewError.error(error)
      }

      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    })
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if tableViewError != nil && employees.isEmpty {
      return 1
    }
    
    return employees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableViewError != nil {
      let cell: ErrorCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.errorLabel.text = tableViewError?.localizedDescription
      return cell
    } else {
      let cell: EmployeeCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.fill(employer: employees[indexPath.row])
      return cell
    }
  }
}

