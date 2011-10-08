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

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet YXModelStaticViewDemoViewController *viewController;

@end
