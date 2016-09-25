//
//  AddPersonViewController.swift
//  Halo
//
//  Created by Annie Ritch on 9/24/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {
    
    var pickedImage: UIImage! //from segue
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //all of the text fields
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var ethnicityField: UITextField!
    @IBOutlet weak var feetField: UITextField!
    @IBOutlet weak var inchesField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    weak var homeButtonDelegate: HomeButtonDelegate?
    @IBAction func homeButtonPressed(sender: UIBarButtonItem) {
        homeButtonDelegate?.homeButtonPressedFrom()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //establish all the text field delegates
        firstNameField.delegate = self
        lastNameField.delegate = self
        dobField.delegate = self
        genderField.delegate = self
        ethnicityField.delegate = self
        feetField.delegate = self
        inchesField.delegate = self
        weightField.delegate = self
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
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
    
    /***** DEAL WITH KEYBOARD *****/
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == ethnicityField || textField == feetField || textField == inchesField || textField == weightField) {
            scrollView.setContentOffset(CGPointMake(0, 150), animated: true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 200, self.view.frame.size.width, self.view.frame.size.height)
    }
    
    /***** ADD INDIVIDUAL *****/
    
    @IBAction func addIndividualButtonPressed(sender: UIButton) {
        //generate random subject id
        let subject_id = randomStringWithLength(16) as String
        print(subject_id)
        let first_name = firstNameField.text!
        let last_name = lastNameField.text!
        let date_of_birth = dobField.text!
        let gender = genderField.text!
        let ethnicity = ethnicityField.text!
        let height_feet = feetField.text!
        let height_inches = inchesField.text!
        let weight = weightField.text!
        
//        let image = RecognitionModel.encodeImage(pickedImage)
        
        //INCLUDING IMAGE MAKES REQUEST TOO LARGE :(
        IndividualModel.addIndividual(subject_id, first_name: first_name, last_name: last_name, gender: gender, date_of_birth: date_of_birth, ethnicity: ethnicity, height_feet: height_feet, height_inches: height_inches, weight: weight) {
            data, response, error in
            //successfully added to database? enroll image
            RecognitionModel.submitImageForEnrollment(self.pickedImage, andId: subject_id) {
                data, response, error in
            }
            //return to home page
            self.homeButtonDelegate?.homeButtonPressedFrom()
        }
        
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for i in 0..<len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }



}
