//
//  Mozscape.swift
//  iMoz
//
//  Created by George Andrews on 5/15/15.
//  Copyright (c) 2015 George Andrews. All rights reserved.
//

import Foundation
import UIKit

let LinksURL = "http://lsapi.seomoz.com/linkscape/url-metrics/"

class Mozscape {
    
    var accessID: String
    var secretKey: String
    var searchURL: String
    
    let COLS = 653574424869
    
    init(searchURL: String, accessID: String, secretKey: String) {
        self.searchURL = searchURL
        self.accessID = accessID
        self.secretKey = secretKey
    }
    
    func getMozDataFromAPIRequest(success: ((mozJSON: NSData!) -> Void)) {
        
        let expiresInterval = (floor(NSDate().timeIntervalSince1970 + 300) as NSNumber).stringValue
        
        var mozDataURL = LinksURL + searchURL.urlencode()
        mozDataURL += "?Cols=" + String(COLS)
        mozDataURL += "&Limit=1"
        mozDataURL += "&AccessID=" + accessID
        mozDataURL += "&Expires=" + expiresInterval
        
        let urlSafeSignature = buildURLSafeSignature(expiresInterval)
        
        mozDataURL += "&Signature=" + urlSafeSignature
        println(mozDataURL)
        
        loadDataFromURL(NSURL(string: mozDataURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(mozJSON: urlData)
            }
            if let dataError = error {
                println(dataError)
            }
        })
    }
    
    private func buildURLSafeSignature(expiresInterval: String) -> String {
        
        let stringToSign = (accessID + "\n" + expiresInterval)
        let sha1Digest = stringToSign.hmacsha1(secretKey)
        let base64Encoded = sha1Digest.base64EncodedDataWithOptions(nil)
        
        return (NSString(data: base64Encoded, encoding: NSUTF8StringEncoding) as! String).urlencode()
    }
    
    private func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
        var session = NSURLSession.sharedSession()
        
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"com.iteachcoding.apps", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
    
    static func formatDate(timeInterval: AnyObject?) -> String {
        if let dateInterval = timeInterval as? NSTimeInterval {
            let date = NSDate(timeIntervalSince1970: dateInterval as NSTimeInterval)
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMMM DD, yyyy"
            return formatter.stringFromDate(date)
            
        }
        return "No date provided."
    }
    
}

extension String {
    
    func urlencode() -> String {
        var urlEncoded = self.stringByReplacingOccurrencesOfString(" ", withString: "+")
        return urlEncoded.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    func hmacsha1(key: String) -> NSData {
        
        let dataToDigest = self.dataUsingEncoding(NSUTF8StringEncoding)
        let secretKey = key.dataUsingEncoding(NSUTF8StringEncoding)
        
        let digestLength = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), secretKey!.bytes, secretKey!.length, dataToDigest!.bytes, dataToDigest!.length, result)
        
        return NSData(bytes: result, length: digestLength)
        
    }
    
}

