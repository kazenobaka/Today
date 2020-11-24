//
//  TodayService.swift
//  Today
//
//  Created by Алексей on 23.11.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class TodayService {
    
    enum Errors: Error {
        case unknown
    }
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
    }()
    
    func getDate(completion: @escaping ((Date?) -> Void)) {
        
        let url = URL(string: "https://run.mocky.io/v3/bacf364e-2086-47bb-b112-58acf9176dc3")!
        
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
    
    func getListDate(completion: @escaping ((Result<[(title: String, date: Date)], TodayService.Errors>) -> Void)) {
        
        let url = URL(string:
            "https://run.mocky.io/v3/87cf62ac-e442-4187-b0fb-1ea35dda6238")!
        
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, request, error in
            guard let data = data else{
                completion(.failure(.unknown))
                return
            }
            
            var listArray = [(title: String, date: Date)]()
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let array = jsonObject as? [Any] ?? []
                
                for element in array {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

                    guard
                        let dictionary = element as? [String: Any],
                        let title = dictionary["title"] as? String,
                        let dateString = dictionary["date"] as? String,
                        let date = dateFormatter.date(from: dateString)
                    else {
                        continue
                    }
                    
                    listArray.append((title: title, date: date))
                }
                completion(.success(listArray))
            } catch {
                completion(.failure(.unknown))
            }
        }
        
        task.resume()
    }

}
    

