//
//  CatsViewController.swift
//  Cats
//
//  Created by Руслан on 25.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import UIKit

let catsTableViewCellIdentifier = "CatsTableViewCell"
let loadTableViewCellIdentifier = "LoadTableViewCell"

class CatsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var catRequest = CatRequest()
    var refreshControl = UIRefreshControl()
    var isDataLoading:Bool=false
    var cats: [Cat] = []
    var cellCount: Int = 0
    var images: [Int:UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        loadCats()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "CatsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTable() {
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление котиков...")
        refreshControl.addTarget(self, action: #selector(refreshCats), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "CatsTableViewCell", bundle: nil), forCellReuseIdentifier: catsTableViewCellIdentifier)
        tableView.register(UINib(nibName: "LoadTableViewCell", bundle: nil), forCellReuseIdentifier: loadTableViewCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
        case cellCount - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: loadTableViewCellIdentifier, for: indexPath) as! LoadTableViewCell
            cell.indicator.startAnimating()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: catsTableViewCellIdentifier, for: indexPath) as! CatsTableViewCell
            if let image = images[row] {
                cell.catImageView.image = image
                cell.indicator.stopAnimating()
            } else {
                cell.catImageView.image = nil
                cell.indicator.startAnimating()
                catRequest.downlandImage(url: cats[row].url) { (image) in
                    guard let image = image else { return }
                    self.images[row] = image
                    DispatchQueue.main.async {
                        cell.catImageView.image = image
                        cell.indicator.stopAnimating()
                        self.tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
                    }                    
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let image = images[indexPath.row] {
            let vc = PresentCatViewController()
            vc.catImage = image
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
           if !isDataLoading{
               loadCats()
           }
        }
    }
    
    @objc func refreshCats() {
        images = [:]
        cats = []
        cellCount = 0
        loadCats()
    }
    
    func loadCats() {
        let contentOffset = self.tableView.contentOffset
        isDataLoading = true
        showHUD()
        catRequest.getCats(completion: { (cats) in
            self.cats.append(contentsOf: cats)
            self.cellCount += 50
            self.isDataLoading = false
            DispatchQueue.main.async {
                self.hideHUD()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.tableView.layoutIfNeeded()
                self.tableView.setContentOffset(contentOffset, animated: false)
            }
        }) { (error) in
            self.hideHUD()
        }
    }
}
