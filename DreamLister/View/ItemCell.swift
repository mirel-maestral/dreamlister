//
//  ItemCell.swift
//  DreamLister
//
//  Created by Mirel Spahić on 12/14/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

   
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configure(item: Item)
    {
        price.text = "\(item.price)"
        title.text = item.title
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
    }
}
