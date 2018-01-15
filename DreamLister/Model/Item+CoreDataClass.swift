//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Mirel Spahić on 12/14/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
