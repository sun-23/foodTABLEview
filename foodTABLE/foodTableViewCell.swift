//
//  foodTableViewCell.swift
//  foodTABLE
//
//  Created by sun on 27/4/2562 BE.
//  Copyright © 2562 sun. All rights reserved.
//

import UIKit

class foodTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageURL: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
