//
//  YXModelStaticViewDemoViewController.m
//  YXModelStaticViewDemo
//
//  Created by Zachary Waldowski on 4/22/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import "YXModelStaticViewDemoViewController.h"

@implementation YXModelStaticViewDemoViewController

- (void)viewDidLoad {
    YXSection * sectionA0 = [YXSection sectionWithHeader:nil footer:nil];
    
    [sectionA0 addCell:[YXSegmentedControlCell cellWithItems:[NSArray arrayWithObjects:@"Cell 1", @"Cell 2", @"Cell 3", nil] value:2 handler:^(id<YXModelCell> sender, NSUInteger value) {
        NSLog(@"Segemented control cell %@ did change value to %d.", sender, value);
    }]];
    
    YXSection * sectionA = [YXSection sectionWithHeader:@"Section A" footer:nil];
    
    [sectionA addCell:[YXSwitchCell cellWithTitle:@"BOOM!" value:NO handler:^(id<YXModelCell> sender, BOOL value) {
        NSLog(@"cell0 changed value to %d", value);
    }]];
    
    [sectionA addCell:[YXDisclosureCell cellWithTitle:@"Advanced" handler:^(id<YXModelCell> sender) {
        NSLog(@"cell1 tapped");
    }]];
    
    YXSection * sectionB = [YXSection sectionWithHeader:nil footer:@"Section B"];
    
    [sectionB addCell:[YXSwitchCell cellWithTitle:@"BAH!" value:YES handler:^(id<YXModelCell> sender, BOOL value) {
        NSLog(@"cell2 changed value to %d", value);
    }]];
    
    YXSection *sectionC = [YXSection sectionWithHeader:@"Section C before" footer:@"Section C after"];
        
    [sectionC addCell:[YXButtonCell cellWithTitle:@"Button" handler:^{
        NSLog(@"button cell tapped");
    }]];
        
    self.sections = [NSArray arrayWithObjects:sectionA0, sectionA, sectionB, sectionC, nil];

    [super viewDidLoad];
}

@end
