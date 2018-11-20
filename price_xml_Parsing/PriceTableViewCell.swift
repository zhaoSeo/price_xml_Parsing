//
//  PriceTableViewCell.swift
//  price_xml_Parsing
//
//  Created by Sang won Seo on 20/11/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    @IBOutlet weak var PriceCellImage: UIImageView!
        {
        didSet {
            PriceCellImage.layer.cornerRadius = 15.0
            PriceCellImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var productNm: UILabel!
    @IBOutlet weak var prdlstDetailNm: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var distributePrice: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
