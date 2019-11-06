//
//  CatsTableViewCell.swift
//  Cats
//
//  Created by Руслан on 25.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import UIKit

class CatsTableViewCell: UITableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        catImageView.layer.cornerRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
    }
}
