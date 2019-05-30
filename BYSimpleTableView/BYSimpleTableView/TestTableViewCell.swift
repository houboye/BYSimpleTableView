//
//  TestTableViewCell.swift
//  BYSimpleTableView
//
//  Created by CardiorayT1 on 2019/5/30.
//  Copyright © 2019 houboye. All rights reserved.
//

import UIKit

class TestTableViewCell: BaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func bind(_ data: Any) {
        textLabel?.text = data as? String
    }

    override func cellDidEndDisplay(by data: Any) {
        print("Display")
    }
}
