//
//  class RedditThreadTableViewCell: UITableViewCell {   @IBOutlet weak var titleLabel: UILabel!   @IBOutlet weak var subredditLabel: UILabel!  } RedditThreadTableViewCell.swift
//  reddit-parser
//
//  Created by Dmytro Akulinin on 27.10.2022.
//

import UIKit

class RedditThreadTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subredditLabel: UILabel!
  @IBOutlet weak var threadImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
