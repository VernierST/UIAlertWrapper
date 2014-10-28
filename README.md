UIAlertWrapper
============

UIAlertWrapper makes using Alert Views and Action Sheets easier by presenting a simple API for both iOS 7 & 8 and both iPads and iPhones.

## Why
With iOS 8 presenting Alert Views and Action Sheets just got a lot more complicated. Because while iOS 8 has a nice new interface for presenting them, iOS 7 doesn't. So if your supporting multiple devices and multiple iOS version your code can quickly turn into something like this:

```swift
class MultipleCodePathsViewController: UIViewController, UIAlertViewDelegate, UIActionSheetDelegate {

    @IBAction func presentAlert(sender: AnyObject) {
        if isiOS8 {
            // Use UIAlertController
            
            // UIAlertController Alert callbacks
        } else {
            // Use UIAlertView
        }
    }
    
    @IBAction func presentActionSheet(sender: AnyObject) {
        if isiOS8 {
            // Use UIAlertController
            
            // UIAlertController Action Sheet callbacks
        } else {
            // Use UIActionSheet
        }
        
        if isiPad {
            // Present popover
        } else {
            // Present modally
        }
    }
    
    // iOS 7 Alert Delegate
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        // UIAlertView callbacks
    }
    
    // iOS 7 Action Sheet Delegate
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        // UIActionSheet callbacks
    }
}
```

Whoa, that got ugly fast. Let's turn this ugly duckling into a swan using UIAlertWrapper.

```swift
class SingleCodePathViewController: UIViewController {

	@IBAction func presentAlert(sender: AnyObject) {
        UIAlertWrapper.presentAlert(title: "Alert Title",
            message: "Alert message",
            cancelButtonTitle: "Cancel",
            otherButtonTitles: ["OK"])
            { (buttonIndex) -> () in
                // Alert View callbacks
        }
    }

    @IBAction func presentActionSheet(sender: AnyObject) {
        UIAlertWrapper.presentActionSheet(title: "Button Alert",
            cancelButtonTitle: "Cancel",
            destructiveButtonTitle: "Delete",
            otherButtonTitles: ["Do Stuff"],
            frame: sender.frame)
            { (buttonIndex) -> () in
                // Action Sheet callbacks
        }
    }
}
```

That's it. No multiple code paths. No more managing delegates and callbacks. Let UIAlertWrapper handle those for you, you have better things to spend your time on.

## Use

UIAlertWrapper has three methods:

**presentActionSheet(title, cancelButtonTitle, destructiveButtonTitle, otherButtonTitles, frame, clickedButtonAtIndex)**

For presenting Action Sheets from a Frame.

**presentActionSheet(title, cancelButtonTitle, destructiveButtonTitle, otherButtonTitles, barButtonItem, clickedButtonAtIndex)**

For presenting Action Sheets from a Bar Button Item.

**presentAlert(title, message, cancelButtonTitle, otherButtonTitles, clickedButtonAtIndex)**

For presenting Alerts.

All of these methods will handling displaying the proper format for the proper device. (Popovers for iPads and modally for iPhones.)


### Example Project

Included is an example project that shows how to use UIAlertWrapper to present Action Sheets and Alert Views on both iOS 7 & 8 and both iPads and iPhones.

### License

Usage is provided under the [MIT License](http://opensource.org/licenses/MIT).  
Copyright (c) 2014 Vernier Software & Technology. All rights reserved.
