//
//  UIAlertWrapper.swift
//  UIAlertWrapper
//
//  Created by Ruben Niculcea on 8/20/14.
//  Copyright (c) 2014 Vernier Software & Technology. All rights reserved.
//

import Foundation
import UIKit

private enum PresententionStyle {
    case Rect (CGRect)
    case BarButton (UIBarButtonItem)
}

private let useAlertController = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1
private let alertDelegate = AlertDelegate()
private var clickedButtonAtIndexBlock:((Int) -> ())?

private class AlertDelegate : NSObject, UIAlertViewDelegate, UIActionSheetDelegate {
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        clickedButtonAtIndexBlock!(buttonIndex)
    }
    
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            clickedButtonAtIndexBlock!(buttonIndex + 1)
        } else {
            clickedButtonAtIndexBlock!(buttonIndex)
        }
    }
}

/**
UIAlertWrapper is a wrapper around UIAlertView/UIActionSheet and UIAlertController in order to simplify supporting both iOS 7 and iOS 8. It is not meant to be an exhaustive wrapper, it merely covers the common use cases around Alert Views and Action Sheets.
*/
class UIAlertWrapper : NSObject {
    private class func topViewController () -> UIViewController {
        let rootViewController = UIApplication.sharedApplication().keyWindow.rootViewController!
        return UIAlertWrapper.topVisibleViewController(rootViewController)
    }
    
    private class func topVisibleViewController(viewController: UIViewController) -> UIViewController {
        if viewController is UITabBarController {
            return UIAlertWrapper.topVisibleViewController((viewController as UITabBarController).selectedViewController!)
        } else if viewController is UINavigationController {
            return UIAlertWrapper.topVisibleViewController((viewController as UINavigationController).visibleViewController)
        } else if viewController.presentedViewController != nil {
            return UIAlertWrapper.topVisibleViewController(viewController.presentedViewController!)
        } else if viewController.childViewControllers.count > 0 {
            return UIAlertWrapper.topVisibleViewController(viewController.childViewControllers.last as UIViewController)
        }
        return viewController
    }
    
    class func presentActionSheet(#title: String?,
        cancelButtonTitle: String,
        destructiveButtonTitle: String?,
        otherButtonTitles: [String],
        barButtonItem:UIBarButtonItem,
        clickedButtonAtIndex:((buttonIndex:Int) -> ())? = nil) {
            
            self.presentActionSheet(title,
                cancelButtonTitle: cancelButtonTitle,
                destructiveButtonTitle: destructiveButtonTitle,
                otherButtonTitles: otherButtonTitles,
                presententionStyle: .BarButton(barButtonItem),
                clickedButtonAtIndex: clickedButtonAtIndex)
    }
    
    class func presentActionSheet(#title: String?,
        cancelButtonTitle: String,
        destructiveButtonTitle:String?,
        otherButtonTitles: [String],
        frame:CGRect,
        clickedButtonAtIndex:((buttonIndex:Int) -> ())? = nil) {
            
            self.presentActionSheet(title,
                cancelButtonTitle: cancelButtonTitle,
                destructiveButtonTitle: destructiveButtonTitle,
                otherButtonTitles: otherButtonTitles,
                presententionStyle: .Rect(frame),
                clickedButtonAtIndex: clickedButtonAtIndex)
    }
    
    private class func presentActionSheet(title: String?,
        cancelButtonTitle: String,
        destructiveButtonTitle:String?,
        otherButtonTitles: [String],
        presententionStyle:PresententionStyle,
        clickedButtonAtIndex:((buttonIndex:Int) -> ())? = nil) {
            
            let currentViewController = UIAlertWrapper.topViewController()
            
            if useAlertController {
                var buttonOffset = 1
                let alert = UIAlertController(title: title, message: nil, preferredStyle: .ActionSheet)
                
                alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler:
                    {(alert: UIAlertAction!) in
                        if let _clickedButtonAtIndex = clickedButtonAtIndex {
                            _clickedButtonAtIndex(buttonIndex: 0)
                        }
                }))
                
                if let _destructiveButtonTitle = destructiveButtonTitle {
                    alert.addAction(UIAlertAction(title: _destructiveButtonTitle, style: .Destructive, handler:
                        {(alert: UIAlertAction!) in
                            if let _clickedButtonAtIndex = clickedButtonAtIndex {
                                _clickedButtonAtIndex(buttonIndex: 1)
                            }
                    }))
                    buttonOffset += 1
                }
                
                for (index, string) in enumerate(otherButtonTitles) {
                    alert.addAction(UIAlertAction(title: string, style: .Default, handler:
                        {(alert: UIAlertAction!) in
                            if let _clickedButtonAtIndex = clickedButtonAtIndex {
                                _clickedButtonAtIndex(buttonIndex: index + buttonOffset)
                            }
                    }))
                }
                
                if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                    switch presententionStyle {
                    case let .Rect(rect):
                        alert.popoverPresentationController?.sourceView = currentViewController.view
                        alert.popoverPresentationController?.sourceRect = rect
                    case let .BarButton(barButton):
                        alert.popoverPresentationController?.barButtonItem = barButton
                    }
                }
                
                currentViewController.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                let alert = UIActionSheet()
                
                if let _title = title {
                    alert.title = _title
                }
                
                if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                    alert.cancelButtonIndex = 0
                    alert.addButtonWithTitle(cancelButtonTitle)
                }
                
                if let _destructiveButtonTitle = destructiveButtonTitle {
                    alert.destructiveButtonIndex = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 1 : 0
                    alert.addButtonWithTitle(_destructiveButtonTitle)
                }
                
                for string in otherButtonTitles {
                    alert.addButtonWithTitle(string)
                }
                
                if let _clickedButtonAtIndex = clickedButtonAtIndex {
                    clickedButtonAtIndexBlock = _clickedButtonAtIndex
                    alert.delegate = alertDelegate
                }
                
                if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                    alert.showInView(currentViewController.view)
                } else {
                    switch presententionStyle {
                    case let .Rect(rect):
                        alert.showFromRect(rect, inView: currentViewController.view, animated: true)
                    case let .BarButton(barButton):
                        alert.showFromBarButtonItem(barButton, animated: true)
                    }
                }
            }
    }
    
    class func presentAlert(#title: String,
        message: String,
        cancelButtonTitle: String,
        otherButtonTitles: [String]? = nil,
        clickedButtonAtIndex:((buttonIndex:Int) -> ())? = nil) {
            
            if useAlertController {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler:
                    {(alert: UIAlertAction!) in
                        if let _clickedButtonAtIndex = clickedButtonAtIndex {
                            _clickedButtonAtIndex(buttonIndex: 0)
                        }
                }))
                
                if let _otherButtonTitles = otherButtonTitles {
                    for (index, string) in enumerate(_otherButtonTitles) {
                        alert.addAction(UIAlertAction(title: string, style: .Default, handler:
                            {(alert: UIAlertAction!) in
                                if let _clickedButtonAtIndex = clickedButtonAtIndex {
                                    _clickedButtonAtIndex(buttonIndex: index + 1)
                                }
                        }))
                    }
                }
                
                let currentViewController = UIAlertWrapper.topViewController()
                currentViewController.presentViewController(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertView()
                alert.addButtonWithTitle(cancelButtonTitle);
                alert.cancelButtonIndex = 0
                alert.title = title
                alert.message = message
                
                if let _otherButtonTitles = otherButtonTitles {
                    for string in _otherButtonTitles {
                        alert.addButtonWithTitle(string)
                    }
                }
                
                if let _clickedButtonAtIndex = clickedButtonAtIndex {
                    clickedButtonAtIndexBlock = _clickedButtonAtIndex
                    alert.delegate = alertDelegate
                }
                
                alert.show()
            }
    }
}
