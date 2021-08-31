//
//  EmployeeCell.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 31.08.2021.
//

import UIKit

class EmployeeCell: UITableViewCell {

  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var telephoneLabel: UILabel!
  
  @IBOutlet var firstSkillLabel: UILabel!
  @IBOutlet var secondSkillLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
