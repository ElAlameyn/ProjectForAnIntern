//
//  EmployeeCell.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 31.08.2021.
//

import UIKit

class EmployeeCell: UITableViewCell {
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var subTitleLabel: UILabel!
  @IBOutlet var detailLabel: UILabel!
  
  func fill(employer: Employee) {
    nameLabel.text = employer.name
    subTitleLabel.text = "Tel: \(employer.phone_number)"
    
    detailLabel.text = employer.skills.joined(separator: "\n")
      
//    detailLabel.text = employer.skills.reduce("") { result, element in
//      result + element + " " + "\n"
//    }
//    for skill in employer.skills {
//      detailLabel.text? += skill + " "
//    }
  }
}
