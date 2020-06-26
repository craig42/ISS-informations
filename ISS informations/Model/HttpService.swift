//
//  HttpService.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import os.log

class HttpService<T:Codable> {
    var data : T?
    
    func getRequest(path:String, callback : @escaping (String) -> Void) {
        let path = Configuration.slash + path
        let url = HttpRequest.makeURL(path: path, dict: nil)
        HttpRequest.getHttp(url: url, body: "", callback: {
            success,error,statusCode in
            if (statusCode == StatusCode.success) {
               callback(success)
            } else {
                os_log("Error cannot get ISS position  %@", type:.error, "\(error)")
            }
        })
    }
    
    func getIssData(forData: String, callback : @escaping (Int)-> Void) {
        getRequest(path: forData , callback: { success in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                if let json = success.data(using: .utf8) {
                    let issPosition = try decoder.decode(T.self, from: json)
                    self.data = issPosition 
                    callback(StatusCode.success)
                }
            } catch {
                os_log("Error cannot parse ISS position %@", type:.error, "\(error)")
            }
            })
    }
    
}
