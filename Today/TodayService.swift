//
//  TodayService.swift
//  Today
//
//  Created by Алексей on 23.11.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class TodayService {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
    }()
    
    let url = URL(string: "https://run.mocky.io/v3/bacf364e-2086-47bb-b112-58acf9176dc3")!
    
    func getDate(completion: @escaping ((Date?) -> Void)) {
        
        var request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, request, error) ->
            Void in
            
            guard let data = data else{
                completion(nil)
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard
                    let dictionary = jsonObject as? [String: Any]
                    else {
                        completion(nil)
                        return
                }
                
                let dateString = dictionary["date"] as? String
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let date = dateFormatter.date(from: dateString ?? "")
                
                completion(date)
                
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
    

