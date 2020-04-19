//
//  ViewController.swift
//  DriveDirect
//
//  Created by Noah Evans on 19/04/2020.
//  Copyright © 2020 Velocity Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    //Define link entry box
    @IBOutlet weak var linkEntryBox: UITextField!
    
    //Define status label
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set status label
        statusLabel.text = String("Paste in a link to get started!")
        //Delegate link entry box
        self.linkEntryBox.delegate = self
    }
    
    
    //When Copy Link button pressed
    @IBAction func getDirectLink(_ sender: Any) {
        //Run getLink function
        getLink()
    }
    
    //When Open Drive button pressed
    @IBAction func openDrive(_ sender: Any) {
        //Define Google Drive URL scheme
        guard let driveAppLink = URL(string: "googledrive://") else { return }
        //Open Google Drive URL scheme
        UIApplication.shared.open(driveAppLink)
    }
    
    //Define action
        func getLink() {
        //Check if entry is empty
        if linkEntryBox.text == "" {
            statusLabel.text = String("Please enter a link and try again!")
        }
        //Define link variable
        let link = String(linkEntryBox.text!)
        //Check is link is valid Drive link
        if link.contains("https://drive.google.com/file/d/"){
            //Replace parts of URL to get the direct link
            var directLink = link.replacingOccurrences(of: "file/d/", with: "uc?export=download&id=")
            directLink = directLink.replacingOccurrences(of: "/view?usp=sharing", with: "")
            directLink = directLink.replacingOccurrences(of: "/view?usp=drivesdk", with: "")
            //Copy final link to device clipboard
            let pasteboard = UIPasteboard.general
            pasteboard.string = directLink
            //Display notice
            statusLabel.text = String("Your direct link has been copied to your clipboard!")
        //If not a valid link
        } else {
            statusLabel.text = String("Sorry, that's not a valid link.")
        }
    }

}


