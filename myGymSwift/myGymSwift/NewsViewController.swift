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

    let cellIdentifier = "newsIdentifier"
    let cellXib = "NewsTableViewCell"
    var refreshControl:UIRefreshControl!
    
    var newsArray: Array<NewsObject> = Array<NewsObject>()
    let newsDataManager = NewsDataManager()
    
    let kShowDetailNews = "showDetailNews"

    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
        getNews()
    }
    
    func setIHM(){
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        tableView?.registerNib(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Relâcher pour rafraîchir")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView?.addSubview(refreshControl)
    }
    
    func getNews(){
    
        newsDataManager.getNewsOrdered { (newsArray) -> Void in
            self.newsArray = newsArray
            self.tableView?.reloadData()
            let range = NSMakeRange(0, 1)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView?.reloadSections(sections, withRowAnimation: .Fade)
            self.refreshControl.endRefreshing()
        }
    }
    
    func refresh(sender:AnyObject)
    {
        getNews()
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
        self.performSegueWithIdentifier(kShowDetailNews, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == kShowDetailNews) {
            let ndvc = segue.destinationViewController as! NewsDetailsViewController
            ndvc.news = newsArray[(tableView?.indexPathForSelectedRow?.row)!]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
