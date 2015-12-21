//
//  SportCollectionViewCell.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var voileView: UIView!
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(sport: SportObject) {

        titleLabel?.text           = sport.name
        footerView.backgroundColor = sport.color
        footerView.alpha           = 0.75
        sportImage.image           = UIImage(named: sport.image)
        voileView.backgroundColor  = sport.color
        
    }
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                super.highlighted = true
                UIView.animateWithDuration(0.25, animations: {
                    self.voileView.alpha = 0.75
                })
            } else if newValue == false {
                super.highlighted = false
                UIView.animateWithDuration(0.25, animations: {
                    self.voileView.alpha = 0.0
                })
            }
        }
    }

}
