//
//  ViewController.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 06.10.2022.
//

import UIKit
import Alamofire


class ViewController: UIViewController, ViewControllerPresenterOutput {
  lazy var presenter = ViewControllerPresenter(output: self)
  
  @IBOutlet weak var tableView: UITableView!
  //  var redditThreads: [RedditThread] = []
  
  let decoder = JSONDecoder()
  let url = "https://www.reddit.com/.json"
  
  
  //  @MainActor
  //  func showLoader(isLoading: Bool) {
  //    print("Showloader Thread \(Thread.isMainThread)")
  //  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // func - showLoader - true
    presenter.fetchData()
    print("View did load")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 600
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
      print("Trying to print cell")
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.redditThreads.count
  }
}


class RedditThreadTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subredditLabel: UILabel!

}

