//
//  EmployeeCell.swift
//  ProjectForAnIntern
//
//  Created by Artiom Kalinkin on 31.08.2021.
//

import UIKit

class EmployeeCell: UITableViewCell {
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var subTitleLabel: UILabel!
  @IBOutlet var detailLabel: UILabel!
  
  func fill(employer: Employee) {
    nameLabel.text = employer.name
    subTitleLabel.text = "Tel: \(employer.phoneNumber)"
//    detailLabel.text = employer.skills.joined(separator: "\n")
    detailLabel.text = employer.skills.map({$0.rawValue}).joined(separator: "\n")
  }
}
