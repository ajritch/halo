//
//  IndividualModel.swift
//  Halo
//
//  Created by Annie Ritch on 9/25/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import Foundation

class IndividualModel {
    
    //get an individual by subject_id
    static func getPersonById(id: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
//        let url = NSURL(string: "http://52.43.223.9/individuals/face/\(id)")
        let url = NSURL(string: "http://Annie-MacBook.local:8000/individuals/face/\(id)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
        task.resume()
    }
    
    //add an individual
    //I took image out of this
    static func addIndividual(subject_id: String, first_name: String, last_name: String, gender: String, date_of_birth: String, ethnicity: String, height_feet: String, height_inches: String, weight: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
//        if let urlToReq = NSURL(string: "http://52.43.223.9/individuals") {
        if let urlToReq = NSURL(string: "http://Annie-MacBook.local:8000/individuals") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["subject_id": subject_id, "first_name": first_name, "last_name": last_name, "gender": gender, "date_of_birth": date_of_birth, "ethnicity": ethnicity, "height_feet": height_feet, "height_inch": height_inches, "weight": weight], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Error adding individual: \(error)")
            }
            
        }
    }
    
    
}