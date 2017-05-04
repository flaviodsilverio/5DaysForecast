//
//  RequestClient.swift
//  5DayForecast
//
//  Created by Flávio Silvério on 04/05/17.
//  Copyright © 2017 Flávio Silvério. All rights reserved.
//

import Foundation

class RequestClient {

    func get(dataFromEndpoint endPoint: String, withCompletion completion: @escaping (_ success: Bool, _ data: JSON?, _ error: String?) -> ()) {
        
            let request = URLRequest(url: URL(string: endPoint)!)
            let sessionConfiguration = URLSessionConfiguration.default
            
            let session = URLSession(configuration: sessionConfiguration)
            
            session.dataTask(with: request){
                data, response, error in
                
                if error != nil {
                    
                    completion(false, nil, error?.localizedDescription)
                    
                } else {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(false, nil,"HTTPResponse Unreadable")
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                            
                            completion(true, json, nil)
                            
                        } catch {
                            completion(false, nil,"Response Unreadable")
                        }
                        
                    } else {
                        completion(false, nil,String(describing: httpResponse.statusCode))
                    }
                }
                
                }.resume()
    }

}
