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
    @IBOutlet weak var titleLeftMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var bodyLeftMarginConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundSelection)
        }
        else{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundDefault)
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundSelection)
        }
        else{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundDefault)
        }
    }
    
    func setData(news: NewsObject) {
        
        titleLabel?.text      = news.title
        titleLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)

        bodyLabel?.text      = news.body
        bodyLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellText)

        dayLabel?.text         = news.day
        dayLabel?.textColor    = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)
        
        titleLeftMarginConstraint.constant = 82
        bodyLeftMarginConstraint .constant = 82

    }
}
