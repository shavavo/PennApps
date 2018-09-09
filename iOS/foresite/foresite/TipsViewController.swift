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
    
    
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var beforeTips: UILabel!
    
    @IBOutlet weak var duringTips: UILabel!
    
    @IBOutlet weak var afterTips: UILabel!
    
    @IBOutlet weak var link: UILabel!
    
    var type:String = "";
    var showBefore:Bool = false;
    
    override func viewDidLoad() {
        print(type)
        
        tipsTitle.text = type
        duringTips.text = Tips.tips[type]![1]
        afterTips.text = Tips.tips[type]![2]
        link.text = Tips.tips[type]![3]
        
        if showBefore {
            beforeTips.text = Tips.tips[type]![0]
        } else {
            beforeLabel.isHidden = true;
            beforeTips.isHidden = true;
        }
    }
}
