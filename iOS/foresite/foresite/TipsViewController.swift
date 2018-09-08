//
//  TipsViewController.swift
//  foresite
//
//  Created by David Cheng on 9/8/18.
//  Copyright © 2018 2DGB. All rights reserved.
//

import Foundation
import UIKit

class TipsViewController: UIViewController {
    @IBOutlet weak var tipsTitle: UILabel!
    
    @IBOutlet weak var duringTips: UILabel!
    
    @IBOutlet weak var afterTips: UILabel!
    
    var type:String = "";
    
    override func viewDidLoad() {
        tipsTitle.text = type
        
    }
}
