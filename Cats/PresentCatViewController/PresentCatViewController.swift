//
//  PresentCatViewController.swift
//  Cats
//
//  Created by Руслан on 26.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import UIKit

class PresentCatViewController: UIViewController {

    @IBOutlet weak var presentImageView: UIImageView!
    
    var catImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentImageView.image = catImage
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PresentCatViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
