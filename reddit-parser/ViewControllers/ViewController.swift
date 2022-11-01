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
    let cellNib = UINib(nibName: "RedditThreadTableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "RedditThreadCell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 200
//    tableView.separatorStyle = .singleLine
    
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
//    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    if let cell = cell as? RedditThreadTableViewCell {
      let redditThread = presenter.redditThreads[indexPath.row]
      cell.titleLabel.text = redditThread.title
      cell.subredditLabel.text = redditThread.subReddit
      if let image = redditThread.image, image.contains("https://b.thumbs.redditmedia.com/") {
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




