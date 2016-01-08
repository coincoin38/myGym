//
//  NewsTableViewCell.swift
//  myGymSwift
//
//  Created by julien gimenez on 07/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(news: NewsObject) {
        
        titleLabel?.text  = news.title
        titleLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)

        bodyLabel?.text   = news.body
        bodyLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCell)

        dayLabel?.text    = news.day
        dayLabel?.textColor    = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)


    }
}
