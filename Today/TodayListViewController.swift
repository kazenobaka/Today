//
//  TodayListViewController.swift
//  Today
//
//  Created by Алексей on 24.11.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class TodayListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let todayService = TodayService()
    
    var array = [(title: String, date: Date)]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        let title = array[indexPath.row].title
        let date = dateFormatter.string(from: array[indexPath.row].date)
        cell.textLabel?.text = "\(title) (\(date))"
        
            return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        todayService.getListDate { [weak self] result in
            switch result {
            case .success(let data):
                self?.array = data
                self?.tableView.reloadData()
            case .failure(let error):
                break
            }
        }
    }
    
}
