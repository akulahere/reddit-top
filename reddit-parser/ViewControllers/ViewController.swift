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
  
  var redditThreads: [RedditThread] = []
  
  let decoder = JSONDecoder()
  let url = "https://www.reddit.com/.json"

  @IBOutlet weak var btn: UIButton!
  
  @MainActor
  func showLoader(isLoading: Bool) {
    print("Showloader Thread \(Thread.isMainThread)")
  }
  
  // func reloadTable()
  override func viewDidLoad() {
    super.viewDidLoad()
    // func - showLoader - true
    presenter.fetchData()
//    Task {
//      await presenter.fetchData()
//    }

    view.backgroundColor = .red
    btn.setTitle("Test", for: .normal)
    // Do any additional setup after loading the view.
  }


}

