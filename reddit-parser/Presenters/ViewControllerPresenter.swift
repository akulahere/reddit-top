//
//  ViewControllerPresenter.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 12.10.2022.
//

import Alamofire

protocol ViewControllerPresenterInput {
  func fetchData()
  
  var redditThreads: [RedditThread] { get }
}

protocol ViewControllerPresenterOutput: AnyObject {
  var tableView: UITableView! { get }
  func updateList()
  func startLoading()
  func stopLoading()
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
    self.output?.startLoading()
    AF.request(url)
      .responseDecodable(of: RedditResponse.self) { (response) in
      guard let threads = response.value?.data.children else { return }
        threads.forEach {
          thread in self.redditThreads.append(thread.data)
        }
        DispatchQueue.main.async {
          self.output?.updateList()
          self.output?.stopLoading()
        }
      }
  }
}
