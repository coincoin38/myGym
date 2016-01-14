//
//  NewsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 10/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import Alamofire

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var newsArray: Array<NewsObject> = Array<NewsObject>()
    let cellIdentifier = "newsIdentifier"
    let cellXib = "NewsTableViewCell"
    let newsDataManager = NewsDataManager()
    
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.registerNib(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        newsDataManager.getNewsOrdered { (newsArray) -> Void in
            self.newsArray = newsArray
            self.tableView?.reloadData()
            let range = NSMakeRange(0, 1)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView?.reloadSections(sections, withRowAnimation: .Fade)
        }
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
