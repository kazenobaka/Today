//
//  ViewController.swift
//  Today
//
//  Created by Алексей on 19.11.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    
    let todayService = TodayService()
    
    @IBOutlet var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        todayService.getDate { [weak self] date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            if let date = date {
                self?.textLabel.text = dateFormatter.string(from: date)
            } else {
                self?.textLabel.text = "Ой все ошибочка"
            }
            
        }
    }


}

