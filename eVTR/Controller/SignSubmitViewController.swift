//
//  SignSubmitViewController.swift
//  eVTR
//
//  Created by Derek Stock on 7/28/16.
//  Copyright © 2016 Ninth Coast. All rights reserved.
//

import UIKit

class SignSubmitViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var suggestionBackgroundView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var suggestionView: UIView!
    @IBOutlet weak var suggestionTextView: UITextView!
    @IBOutlet weak var checkingBoxAgree: UIButton!
    
    var isAgree: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameView.layer.cornerRadius = 3; emailView.layer.cornerRadius = 3;  suggestionView.layer.cornerRadius = 3; suggestionTextView.layer.cornerRadius = 3
        
        checkingBoxAgree.layer.cornerRadius = Constants.ButtonCornorRadius
        checkingBoxAgree.layer.borderWidth = 0.5
        checkingBoxAgree.layer.borderColor = Constants.Colors.FieldBorder.CGColor
        
        suggestionTextView.delegate = self
        suggestionTextView.text = "What's your suggestion?"
        suggestionTextView.textColor = UIColor.lightGrayColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: UIButton Action.
    @IBAction func didTapRememberMe(sender: AnyObject) {
        isAgree = !isAgree
        if isAgree == true {
            checkingBoxAgree.setImage(UIImage(named: "checkmark"), forState: .Normal)
        } else {
            checkingBoxAgree.setImage(UIImage(named: "checkmark_none"), forState: .Normal)
        }
    }

    @IBAction func didTapSubmitReport(sender: AnyObject) {
        
        suggestionBackgroundView.hidden = false
    }
    
    @IBAction func didTapCancelSubmit(sender: UIButton) {
        suggestionBackgroundView.hidden = true
    }
    
    @IBAction func didTapSubmitSuggestion(sender: AnyObject) {
        suggestionBackgroundView.hidden = true
    }
    
    // MARK: UITextView Delegate.
    func textViewDidBeginEditing(textView: UITextView) {
        
        if suggestionTextView.textColor == UIColor.lightGrayColor() {
            suggestionTextView.text = ""
            suggestionTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if suggestionTextView.text == "" {
            
            suggestionTextView.text = "What's your suggestion?"
            suggestionTextView.textColor = UIColor.lightGrayColor()
        }
    }
}

