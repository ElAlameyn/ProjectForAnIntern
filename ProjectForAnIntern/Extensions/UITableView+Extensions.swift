//
//  UITableView+Extensions.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 31.08.2021.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
      fatalError("Wrong identifier")
    }
    return cell
  }
}
