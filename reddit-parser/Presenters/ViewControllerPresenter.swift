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
}

class ViewControllerPresenter: ViewControllerPresenterInput {
  weak var output: ViewControllerPresenterOutput?
  let decoder = JSONDecoder()
  let url = "https://www.reddit.com/.json"
  var redditThreads: [RedditThread] = []
  
  init(output vc: ViewControllerPresenterOutput) {
    self.output = vc
  }
  
  // func startApp() { }
  
  
  
//  func fetchData() async {
//    output?.showLoader(isLoading: true)
//    print("\(Thread.isMainThread)")
//    let response = await AF.request(url).serializingDecodable(RedditResponse.self).response
//    guard let threads = response.value?.data.children else { return }
//    threads.forEach { thread in
//      self.redditThreads.append(thread.data)
//    }
//    print("\(Thread.isMainThread)")
//    output?.showLoader(isLoading: true)
//
//    await MainActor.run {
//      print(self.redditThreads)
//    }
    
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
          self.output?.tableView.reloadData()
        }
      }
  }
}
