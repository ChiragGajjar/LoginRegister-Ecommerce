//
//  ProductCell.swift
//  eCommerce Buyer
//
//  Created by Theappfathers on 08/04/20.
//  Copyright © 2020 Theappfathers. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    static var userIdentifier = "ProductCell"
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
