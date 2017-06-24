//
//  PredmetTableViewCell.swift
//  TomislavLipovacRaspored
//
//  Created by User on 06/04/16.
//  Copyright © 2016 TomislavLipovac. All rights reserved.
//

import UIKit

class PredmetTableViewCell: UITableViewCell {

    @IBOutlet weak var nazivPredmeta: UILabel!
    @IBOutlet weak var danVrijeme: UILabel!
    @IBOutlet weak var prostorija: UILabel!
    @IBOutlet weak var slikaPredmeta: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
