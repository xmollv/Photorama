//
//  FlickerAPI.swift
//  Photorama
//
//  Created by Xavi Moll on 18/08/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

struct FlickerAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "4413d7cb9dfde772cfb54dce281cc5e3"
    
    private static func flickrURL(methid method: Method, parameters: [String:String]?) -> NSURL {
        let components = NSURLComponents(string: baseURLString)!
        
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "method"        : method.rawValue,
            "format"        : "json",
            "nojsoncallback": "1",
            "api_key"       : APIKey
        ]
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.URL!
    }
    
    static func recentPhotosURL() -> NSURL {
        return flickrURL(methid: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
    }
}