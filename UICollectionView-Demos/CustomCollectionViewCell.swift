//
//  CustomCollectionViewCell.swift
//  UICollectionView-Demos
//
//  Created by Pavel Palancica on 4/4/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithItem(_ item: String) {
        numberLabel.text = item
    }
}
