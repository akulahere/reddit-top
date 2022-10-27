//
//  ViewControllerPresenter.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 12.10.2022.
//

import Foundation
import Alamofire

protocol ViewControllerPresenterInput {
//  func fetchData() async
  func fetchData()

  var redditThreads: [RedditThread] { get }
}

protocol ViewControllerPresenterOutput: AnyObject {
//  func showLoader(isLoading: Bool)
  var tableView: UITableView! { get }
  func updateList()
}

class ViewControllerPresenter: ViewControllerPresenterInput {
  weak var output: ViewControllerPresenterOutput?
  let decoder = JSONDecoder()
  let url = "https://www.reddit.com/.json"
  var redditThreads: [RedditThread] = []
  
  init(output vc: ViewControllerPresenterOutput) {
    self.output = vc
  }
  
  func fetchData() {
    AF.request(url)
      .responseDecodable(of: RedditResponse.self) { (response) in
      guard let threads = response.value?.data.children else { return }
        threads.forEach {
          thread in self.redditThreads.append(thread.data)
        }
        DispatchQueue.main.async {
          print("Reload data")
          print(self.redditThreads.count)
          self.output?.updateList()
        }
      }
  }
}
