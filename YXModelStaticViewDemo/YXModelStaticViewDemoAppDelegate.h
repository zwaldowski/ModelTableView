//
//  YXModelStaticViewDemoAppDelegate.h
//  YXModelStaticViewDemo
//
//  Created by Zachary Waldowski on 4/22/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXModelStaticViewDemoViewController;

@interface YXModelStaticViewDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet YXModelStaticViewDemoViewController *viewController;

@end
