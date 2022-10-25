//
//  RedditThread.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 12.10.2022.
//

import Foundation

struct RedditThread: Codable {
  let title: String
  let description: String?
  let subReddit: String
  let image: String?
  
  enum CodingKeys: String, CodingKey {
    case title
    case description
    case subReddit = "subreddit_name_prefixed"
    case image = "thumbnail"
  }
}

// MARK: - Decodable
//extension RedditThread: Codable {
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    title = try container.decode(String.self, forKey: .title)
//    description = try container.decode(String.self, forKey: .description)
//    subReddit = try container.decode(String.self, forKey: .subReddit)
//    image = try? container.decode(String.self, forKey: .image)
//  }
//}

struct RedditDataChildren: Codable {
  let data: RedditThread
}



struct RedditData: Codable {
  let children: [RedditDataChildren]
}



struct RedditResponse: Codable {
  let data: RedditData
}



