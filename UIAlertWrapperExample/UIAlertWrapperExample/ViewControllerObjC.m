//
//  ViewControllerObjC.m
//  UIAlertWrapperExample
//
//  Created by Ruben Niculcea on 9/23/14.
//  Copyright (c) 2014 Ruben Niculcea. All rights reserved.
//

#import "ViewControllerObjC.h"

#import "UIAlertWrapperExample-swift.h"

@implementation ViewControllerObjC

- (IBAction)alertViewPresent:(UIButton *)sender
{
    [UIAlertWrapper presentAlertWithTitle:@"Alert Title"
                                  message:@"Alert message"
                        cancelButtonTitle:@"Cancel"
                        otherButtonTitles:@[@"OK"]
                     clickedButtonAtIndex:^(NSInteger buttonIndex) {
                         switch (buttonIndex) {
                             case 0:
                                 NSLog(@"Cancel Button pressed");
                                 break;
                             case 1:
                                 NSLog(@"OK Button pressed");
                                 break;
                             default:
                                 NSLog(@"No Idea what was pressed");
                         }
                     }];
}

- (IBAction)barButtonItemActionPresent:(UIBarButtonItem *)sender
{
    [UIAlertWrapper presentActionSheetWithTitle:nil
                              cancelButtonTitle:@"Cancel"
                         destructiveButtonTitle:nil
                              otherButtonTitles:@[@"Do Stuff"]
                                  barButtonItem:sender
                           clickedButtonAtIndex:^(NSInteger buttonIndex) {
                               switch (buttonIndex) {
                                   case 0:
                                       NSLog(@"Cancel Button pressed");
                                       break;
                                   case 1:
                                       NSLog(@"Do Stuff pressed");
                                       break;
                                   default:
                                       NSLog(@"No Idea what was pressed");
                               }
                           }];
}

- (IBAction)buttonActionPresent:(UIButton *)sender
{
    [UIAlertWrapper presentActionSheetWithTitle:@"Button Alert"
                              cancelButtonTitle:@"Cancel"
                         destructiveButtonTitle:@"Delete"
                              otherButtonTitles:@[@"Do Stuff"]
                                          frame:sender.frame
                           clickedButtonAtIndex:^(NSInteger buttonIndex) {
                               switch (buttonIndex) {
                                   case 0:
                                       NSLog(@"Cancel Button pressed");
                                       break;
                                   case 1:
                                       NSLog(@"Delete pressed");
                                       break;
                                   case 2:
                                       NSLog(@"Do Stuff pressed");
                                       break;
                                   default:
                                       NSLog(@"No Idea what was pressed");
                               }
                           }];
}

@end
