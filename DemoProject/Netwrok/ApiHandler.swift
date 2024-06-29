//
//  ApiHandler.swift
//  DemoProject
//
//  Created by Newmac on 28/06/23.
//

import UIKit
import Foundation
import Alamofire
import SDWebImage
import SwiftLoader


class ApiHandler {
    
    //MARK: Get API
    class func getApi<T: Decodable>(responseType: T.Type, header: [String: Any]? = nil, id: Int? = nil, params: [String: Any]? = nil, city: String? = nil, progressView: UIView? = nil, completionHandler: @escaping (T?, String?) -> Void
    ) {
        SwiftLoader.show(animated: true)
        let urlString = "http://api.weatherapi.com/v1/forecast.json?key=c0b26ff972744a9fbae195222242806&q=\(city ?? "")&days=1"
        debugPrint("urlString == \(urlString)")
        
        let headers = HTTPHeaders()
        
        AF.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { response in
            DispatchQueue.main.async {
                SwiftLoader.hide()
                
                switch response.result {
                case .success(let data):
                    guard let statusCode = response.response?.statusCode else {
                        completionHandler(nil, "Unknown status code")
                        return
                    }
                    
                    switch statusCode {
                    case 200...299:
                        do {
                            let dataReceived = try JSONDecoder().decode(T.self, from: data)
                            completionHandler(dataReceived, nil)
                        } catch {
                            completionHandler(nil, "Failed to decode response")
                        }
                    default:
                        if let message = parseErrorMessage(data: data) {
                            completionHandler(nil, message)
                        } else {
                            completionHandler(nil, "HTTP Error: \(statusCode)")
                        }
                    }
                    
                case .failure:
                    completionHandler(nil, "Network request failed")
                }
            }
        }
    }
    
    // Function to parse error message from API response
    private static func parseErrorMessage(data: Data) -> String? {
        do {
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let errorDict = json["error"] as? [String: Any],
               
               let message = errorDict["message"] as? String {
                return message
            }
        } catch {
            debugPrint("Error parsing error message: \(error.localizedDescription)")
        }
        return nil
    }
}
