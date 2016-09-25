//
//  ShowPersonViewController.swift
//  Halo
//
//  Created by Annie Ritch on 9/24/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit

class ShowPersonViewController: UIViewController {
    
    //labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    var shelterTime: Int = 2
    var foodTime: Int = 1
    
    var pickedImage: UIImage! //get this from segue!
    var subject: String!
    
    //for "page loading" type stuff
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    weak var homeButtonDelegate: HomeButtonDelegate?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var localResourcesButton: UIButton!
    @IBOutlet weak var professionalResourcesButton: UIButton!
    
    @IBOutlet weak var shelterButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var alertsButton: UIButton!
    
    
    @IBAction func homeButtonPressed(sender: UIBarButtonItem) {
        homeButtonDelegate?.homeButtonPressedFrom()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingOverlay(view)

        // Do any additional setup after loading the view.
        localResourcesButton.layer.borderWidth = 1
        localResourcesButton.layer.borderColor = UIColor.grayColor().CGColor
        professionalResourcesButton.layer.borderWidth = 1
        professionalResourcesButton.layer.borderColor = UIColor.grayColor().CGColor
        shelterButton.layer.cornerRadius = 10
        foodButton.layer.cornerRadius = 10
        alertsButton.layer.cornerRadius = 10
        
        //set image view
        imageView.contentMode = .ScaleAspectFit
        imageView.autoresizesSubviews = true
        imageView.image = pickedImage!
        
        IndividualModel.getPersonById(subject) {
            data, response, error in
            do {
                if let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    print(results)
                    if let first_name = results["first_name"] as? String {
                        if let last_name = results["last_name"] as? String {
                            self.nameLabel.text = "\(first_name) \(last_name)"
                        }
                    }
                    if let gender = results["gender"] as? String {
                        self.genderLabel.text = "\(gender)"
                    }
                    if let weight = results["weight"] as? Int {
                        self.weightLabel.text = "\(weight) lbs"
                    }
//                    if let height_inches = results["height_inches"] as? String {
                        if let height_feet = results["height_feet"] as? Int {
                            self.heightLabel.text = "\(height_feet)' \(5)\""
                        }
//                    }
                }
                self.hideLoadingOverlay()
            } catch {
                print("Something went wrong")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /***** BUTTONS PRESSED *****/
    
    //user presses emergency button
    @IBAction func emergencyButtonPressed(sender: UIBarButtonItem) {
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
    
    //shelter button pressed
    @IBAction func shelterButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "Last checked into shelter \(shelterTime) day(s) ago", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) {
            (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //food button pressed
    @IBAction func foodButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "Last checked in for food \(foodTime) day(s) ago", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) {
            (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //alerts button pressed
    @IBAction func alertsButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "Medical Alert", message: "Epileptic", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) {
            (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
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
    
    //function to stop loading screen
    func hideLoadingOverlay() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
        

}
