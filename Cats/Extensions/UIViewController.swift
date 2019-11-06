//
//  UIViewController.swift
//  Cats
//
//  Created by Руслан on 04.11.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showHUD() {
        let hud = ProgressHUDViewController()
        add(hud)
    }
    
    func hideHUD() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
