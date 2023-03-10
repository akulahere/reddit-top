//
//  SpinnerViewController.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 02.11.2022.
//

import UIKit

class SpinnerViewController: UIViewController {
  var spinner = UIActivityIndicatorView(style: .large)
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor(white: 0, alpha: 0.7)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
