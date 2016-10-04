//
//  RecognitionModel.swift
//  Halo
//
//  Created by Annie Ritch on 9/24/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import Foundation
import UIKit

//TAKE THESE OUT BEFORE GITHUB!!! :)
var app_id = "99481d3a"  //insert id
var app_key = "d6969f887be0078262a82c74bad835a3" //insert key

class RecognitionModel {
    
    //encode the image -> JPEG to Base64
    static func encodeImage(image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1.0)!
        let strBase64 = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return strBase64
    }
    
    //submit image for recognition in API
    static func submitImageForRecognition(image: UIImage, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        //set up the request
        if let urlToReq = NSURL(string: "https://api.kairos.com/recognize") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(app_id, forHTTPHeaderField: "app_id")
            request.setValue(app_key, forHTTPHeaderField: "app_key")
            
            do {
                //encode and pass image over JSON
                let encodedImage = encodeImage(image)
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["image":encodedImage, "gallery_name":"halofaces"], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Recognition Error: \(error)")
            }
        }
    }
    
    //submit image for enrollment in API
    //id is randomly generated elsewhere
    static func submitImageForEnrollment(image: UIImage, andId: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        //set up the request
        if let urlToReq = NSURL(string: "https://api.kairos.com/enroll") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(app_id, forHTTPHeaderField: "app_id")
            request.setValue(app_key, forHTTPHeaderField: "app_key")
            
            //encode and pass image over json
            do {
                let encodedImage = encodeImage(image)
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["image":encodedImage, "gallery_name":"halofaces", "subject_id":andId, "selector":"SETPOSE"], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Enrollment Error: \(error)")
            }
        }
    }
    
    
}