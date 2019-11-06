//
//  LoadTableViewCell.swift
//  Cats
//
//  Created by Руслан on 02.11.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import UIKit

class LoadTableViewCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
