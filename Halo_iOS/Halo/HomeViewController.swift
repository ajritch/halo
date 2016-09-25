//
//  HomeViewController.swift
//  Halo
//
//  Created by Annie Ritch on 9/24/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HomeButtonDelegate {
    
    let locationManager = CLLocationManager()
    let imagePicker = UIImagePickerController()
    var image: UIImage!
    //for "page loading" type stuff
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var logoView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add logo
        logoView.contentMode = .ScaleAspectFit
        logoView.autoresizesSubviews = true
        logoView.image = UIImage(imageLiteral: "halo-logo-small.png")
        
        //turn on location tracking
        self.locationManager.requestWhenInUseAuthorization() //only track when app in use
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
        }
        //set image picker delegate
        imagePicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //user presses emergency button
    @IBAction func emergencyButtonPressed(sender: UIButton) {
        //make alert controller to confirm user wants to make call
        let alert = UIAlertController(title: "Emergency Call", message: "Are you sure?", preferredStyle: .Alert)
        
        //action to make call
        let makeCallAction = UIAlertAction(title: "Call 911", style: .Default) {
            (action: UIAlertAction!) -> Void in
            let url: NSURL = NSURL(string: "tel://6502915651")!
            UIApplication.sharedApplication().openURL(url)
        }
        
        //action to cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction) -> Void in
            //do nothing
        }
        
        //register everything
        alert.addAction(makeCallAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //user presses button to take photo
    @IBAction func takePhotoButtonPressed(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //user has taken a photo!
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            image = pickedImage
            
            //dismiss image picker, show a loading overlay
            dismissViewControllerAnimated(true, completion: nil)
            showLoadingOverlay(view)

            
            //try submitting the image for recognition
            RecognitionModel.submitImageForRecognition(pickedImage) {
                data, response, error in
                do {
                    //dictionary of all api response data
                    if let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        //array of return image info
                        if let imageArray = results["images"] as? NSArray {
                            //take only first (most confident) result
                            if let transaction = imageArray[0]["transaction"] as? NSDictionary {
                                if let status = transaction["status"] as? String {
                                    //if successful recognition, proceed with subject name
                                    if status == "success" {
                                        if let subject = transaction["subject"] as? String {
                                            print(subject)
                                            //show the person via segue
                                
                                            dispatch_async(dispatch_get_main_queue(), {
                                                self.hideLoadingOverlay()
                                                self.performSegueWithIdentifier("ShowPersonSegue", sender: ["image": pickedImage, "subject": subject])
                                            })
                                        }
                                        
                                        
                                    } else {
                                        
                                        //no matches found
                                        if let message = transaction["message"] as? String {
                                            if message == "No match found" {
                                                print(message)
                                                //as user to add photo to gallery
                                                dispatch_async(dispatch_get_main_queue(), {
                                                    self.hideLoadingOverlay()
                                                    self.addEnrollImageAlert()
                                                })
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        //couldn't find a face? separate error object returned
                        if let errorResults = results["Errors"] as? NSArray {
                            if let error = errorResults[0] as? NSDictionary {
                                //get "error" message
                                if let message = error["Message"] as? String {
                                    if message == "no faces found in the image" {
                                        print(message)
                                        //inform user that no faces were detected in image
                                        self.addNoFacesAlert()
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("Error with Recognition: \(error)")
                }
            }
        }
    }
    
    
    //get user's current coordinates
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
    
    /***** LOADING *****/
    
    //function to show loading screen
    func showLoadingOverlay(view: UIView) {
        overlayView.frame = CGRectMake(0, 0, 80, 80)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(white: 0.3, alpha: 0.6)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = CGPointMake(overlayView.bounds.width / 2, overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    //funciton to stop loading screen
    func hideLoadingOverlay() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    /***** ALERTS *****/
    
    //alert that no face was detected
    func addNoFacesAlert() {
        let alert = UIAlertController(title: "No Faces Detected", message: "Try taking another photo", preferredStyle: .Alert)
        
        let tryAgainAction = UIAlertAction(title: "Okay", style: .Default) {
            (action: UIAlertAction!) -> Void in
            //do nothing
        }
        
        alert.addAction(tryAgainAction)
        
        //update UI
        dispatch_async(dispatch_get_main_queue(), {
            self.hideLoadingOverlay()
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    //alert to enroll new image
    func addEnrollImageAlert() {
        let alert = UIAlertController(title: "No Matches Found", message: "Add a new individual", preferredStyle: .Alert)
        
        //user clicks Add Face
        let addFaceAction = UIAlertAction(title: "Add Individual", style: .Default) {
            (action: UIAlertAction!) -> Void in
            //ADD IMPLEMENTATION TO SEGUE TO AN ADD PAGE OR SOMETHING
            let pickedImage = self.image
            self.performSegueWithIdentifier("AddPersonSegue", sender: pickedImage)
        }
        
        //user clicks cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction) -> Void in //do nothing
        }
        
        //register buttons to alert box
        alert.addAction(addFaceAction)
        alert.addAction(cancelAction)
        
        //register alert box to view controller
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }

    
    
    /***** SEGUES *****/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //add a new person
        if segue.identifier == "AddPersonSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addPersonViewController = navigationController.topViewController as! AddPersonViewController
            addPersonViewController.pickedImage = sender as! UIImage
            addPersonViewController.homeButtonDelegate = self
        }
        
        //show the person once identified
        if segue.identifier == "ShowPersonSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let showPersonViewController = navigationController.topViewController as! ShowPersonViewController
            showPersonViewController.pickedImage = sender!["image"] as! UIImage
            showPersonViewController.subject = sender!["subject"] as! String
            showPersonViewController.homeButtonDelegate = self
            
            //populate all the person info on other side
//            IndividualModel.getPersonById(sender!["subject"]) {
//                data, response, error in
//                do {
//                    if let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                        print(results)
//                    }
//                    
//                } catch {
//                    print("Something went wrong")
//                }
//            }
        }
        
        //get user by subject ID from backend?
    }

    /***** ETC *****/
    
    func homeButtonPressedFrom() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

