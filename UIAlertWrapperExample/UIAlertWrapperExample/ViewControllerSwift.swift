//
//  ViewControllerSwift.swift
//  UIAlertWrapperExample
//
//  Created by Ruben Niculcea on 9/23/14.
//  Copyright (c) 2014 Ruben Niculcea. All rights reserved.
//

import UIKit

class ViewControllerSwift: UIViewController {
    
    @IBAction func alertViewPresent(sender: UIButton) {
        UIAlertWrapper.presentAlert(title: "Alert Title",
            message: "Alert message",
            cancelButtonTitle: "Cancel",
            otherButtonTitles: ["OK"])
            { (buttonIndex) -> () in
                switch buttonIndex {
                case 0:
                    println("Cancel Button pressed")
                case 1:
                    println("OK Button pressed")
                default:
                    println("No Idea what was pressed")
                }
        }
    }
    
    @IBAction func barButtonItemActionPresent(sender: UIBarButtonItem) {
        UIAlertWrapper.presentActionSheet(title: nil,
            cancelButtonTitle: "Cancel",
            destructiveButtonTitle:nil,
            otherButtonTitles: ["Do Stuff"],
            barButtonItem: sender)
            { (buttonIndex) -> () in
                switch buttonIndex {
                case 0:
                    println("Cancel Button pressed")
                case 1:
                    println("Do Stuff pressed")
                default:
                    println("No Idea what was pressed")
                }
        }
    }
    
    @IBAction func buttonActionPresent(sender: UIButton) {
        UIAlertWrapper.presentActionSheet(title: "Button Alert",
            cancelButtonTitle: "Cancel",
            destructiveButtonTitle: "Delete",
            otherButtonTitles: ["Do Stuff"],
            frame: sender.frame)
            { (buttonIndex) -> () in
                switch buttonIndex {
                case 0:
                    println("Cancel Button pressed")
                case 1:
                    println("Delete pressed")
                case 2:
                    println("Do Stuff pressed")
                default:
                    println("No Idea what was pressed")
                }
        }
    }
}

