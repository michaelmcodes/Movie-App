//
//  ListTableViewCell.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
