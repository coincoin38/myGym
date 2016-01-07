//
//  NewsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 10/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var newsArray: Array<NewsObject> = Array<NewsObject>()
    let cellIdentifier = "newsIdentifier"
    let cellXib = "NewsTableViewCell"
    var alreadyLoading: Bool = Bool()
    
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.registerNib(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        RealmManager.SharedInstance.getAllNews { (news) -> Void in
            
            for new in news {
                let newsObject = NewsObject()
                
                newsObject.setNewsForCell(new, completion: { (newsObject) -> Void in
                    self.newsArray.append(newsObject)
                })
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if !alreadyLoading{
            animateTable()
        }
    }
    
    func animateTable() {
        
        let cells = tableView!.visibleCells
        let tableHeight: CGFloat = tableView!.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.25, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
        alreadyLoading = true
    }
    
    // MARK: - TableView delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! NewsTableViewCell
        cell.setData(newsArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
