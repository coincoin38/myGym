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
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(sport: SportObject) {

        titleLabel?.text           = sport.name
        footerView.backgroundColor = sport.color
    }
}
