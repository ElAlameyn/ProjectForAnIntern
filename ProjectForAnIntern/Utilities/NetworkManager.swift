//
//  NetworkManager.swift
//  ProjectForAnIntern
//
//  Created by Артем Калинкин on 08.09.2021.
//

import UIKit
import Network

class NetworkManager {
  private let monitor = NWPathMonitor()
  private var banner: UIView?
  
  // only work on real device
  func startMonitoring() {
    
    monitor.start(queue: DispatchQueue.main)
    
    monitor.pathUpdateHandler = { [weak self] path in
      switch path.status {
      case .satisfied:
        self?.banner?.removeFromSuperview()
        self?.banner = nil
        break
      case .unsatisfied, .requiresConnection:
        self?.banner = self?.addBanner()
        break
      @unknown default:
        break
      }
    }
  }
  
  private func addBanner() -> UIView? {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .callout)
    label.textColor = .white
    label.text = "No Internet Connection"
    label.textAlignment = .center
    label.backgroundColor = .systemRed
    guard let viewController = UIApplication.shared.windows.first!.rootViewController else { return nil }
    viewController.view.addSubview(label)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    let horizontalConstraint = label.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor)
    let verticalConstraint = label.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
    let topConstraint = label.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor)
    let heightConstraint = label.heightAnchor.constraint(equalToConstant: 50)
    
    viewController.view.addConstraints([horizontalConstraint, verticalConstraint, topConstraint, heightConstraint])
    return label
  }
}
