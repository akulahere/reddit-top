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
  let loader = SpinnerViewController()

  
  @IBOutlet weak var tableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // func - showLoader - true
    
    presenter.fetchData()
    let cellNib = UINib(nibName: "RedditThreadTableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "RedditThreadCell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 200    
  }
  
  func updateList() {
    tableView.reloadData()
  }
  
  
  func startLoading() {
    showLoader(needToShow: true)
  }
  
  func stopLoading() {
    showLoader(needToShow: false)
  }
  
  func showLoader(needToShow: Bool) {
    if needToShow == true {
      addChild(loader)
      loader.view.frame = view.frame
      view.addSubview(loader.view)
      loader.didMove(toParent: self)
    } else {
      print("try to remove")
      loader.willMove(toParent: nil)
      loader.view.removeFromSuperview()
      loader.removeFromParent()
    }
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




