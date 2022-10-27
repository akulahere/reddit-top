//
//  ViewController.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 06.10.2022.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, ViewControllerPresenterOutput {
  lazy var presenter = ViewControllerPresenter(output: self)
  
  @IBOutlet weak var tableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // func - showLoader - true
    presenter.fetchData()
//    tableView.rowHeight = UITableView.automaticDimension
//    tableView.estimatedRowHeight = 200
    let cellNib = UINib(nibName: "RedditThreadTableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "RedditThreadCell")
  }
  
  func updateList() {
    tableView.reloadData()
  }
}


extension ViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "RedditThreadCell", for: indexPath)
    
    if let cell = cell as? RedditThreadTableViewCell {
      let redditThread = presenter.redditThreads[indexPath.row]
      cell.titleLabel.text = redditThread.title
      cell.subredditLabel.text = redditThread.subReddit
      if let image = redditThread.image {
        let url = URL(string: image)
        cell.threadImageView.kf.setImage(with: url)
      }

    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.redditThreads.count
  }
}




