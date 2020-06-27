//
//  Network.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import os.log

class HttpRequest {
    static func makeURL(path: String, dict: [String: String]?) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Configuration.scheme
        urlComponents.host = Configuration.host
        urlComponents.port = Configuration.port
        urlComponents.path = path
        if let dict = dict {
            urlComponents.queryItems = []
            for (name, value) in dict {
                urlComponents.queryItems?.append(URLQueryItem(name: name, value: value))
            }
        }
        return urlComponents.url!
    }
    static func getHttp(url: URL, body: String, callback : @escaping (String, String, StatusCode) -> Void ) {
        var request = URLRequest(url: url)
        request.httpMethod = Configuration.httpMethod
        let postString = body
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {  // check for networking error
                if let error = error {
                    os_log("Error : %@", type: .error, "\(error)" )
                    callback("", "error=\(error)", StatusCode.error)
                }
                return
            }
            let httpStatus = response as? HTTPURLResponse
            os_log("StatusCode is : %@", type: .info, "\(httpStatus?.statusCode ?? 0)")
            os_log("Request : %@", type: .debug, "\(request)" )
            let responseString = String(data: data, encoding: .utf8)
            if httpStatus?.statusCode == 200 {
                callback(responseString ?? "", "", StatusCode.success)
            } else {
                callback("", responseString ?? "", StatusCode.error)
            }
        }
        task.resume()
    }
}
