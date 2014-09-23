UIAlertWrapper
============

UIAlertWrapper makes using UIAlertViews and UIActionSheets easier by presenting a simple API for both iOS 7 & 8 and both iPads and iPhones.

### Usage
```swift
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
```

Also included is an example project that shows how to use UIAlertWrapper to present Action Sheets and Alert Views on both iOS 7 & 8 and both iPads and iPhones.

### License

Usage is provided under the [MIT License](http://opensource.org/licenses/MIT).  
Copyright (c) 2014 Vernier Software & Technology. All rights reserved.
