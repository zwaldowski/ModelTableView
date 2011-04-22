//
//  YXModelStaticViewDemoViewController.m
//  YXModelStaticViewDemo
//
//  Created by Zachary Waldowski on 4/22/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import "YXModelStaticViewDemoViewController.h"

@implementation YXModelStaticViewDemoViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    YXSection * sectionA0 = [[YXSection alloc] initWithHeader:nil footer:nil];
    [sectionA0 addCell:[YXSegmentedControlCell cellWithReuseIdentifier:@"selectedSegmentControlCell"
                                                 segmentedControlItems:[NSArray arrayWithObjects:@"Cell 1", @"Cell 2", @"Cell 3", nil]
                                                                target:self
                                                                action:@selector(segmentedControlCell:didChangeValue:)
                                                    initialValueGetter:@selector(segmentedControlSelectedIndex:)]];
    
    
    YXSection * sectionA = [[YXSection alloc] initWithHeader:@"Section A" footer:nil];
    
    
    [sectionA addCell:[YXSwitchCell cellWithReuseIdentifier:@"cell0"
													  title:@"BOOM!"
													 target:self
										 initialValueGetter:@selector(cell0InitialValue:)
													 action:@selector(cell0:changedValue:)]];
    
    [sectionA addCell:[YXDisclosureCell cellWithReuseIdentifier:@"cell1"
														  title:@"Advanced"
														  value:nil
														 target:self
														 action:@selector(cell1Tapped:)]];
    
    
    YXSection * sectionB = [[YXSection alloc] initWithHeader:nil footer:@"Section B"];
    [sectionB addCell:[YXSwitchCell cellWithReuseIdentifier:@"cell2"
													  title:@"BAH!1"
													 target:self
										 initialValueGetter:@selector(cell2InitialValue:)
													 action:@selector(cell2:changedValue:)]];
    
    YXSection * sectionC = [[YXSection alloc] initWithHeader:@"Section C before" footer:@"Section C after"];
    [sectionC addCell:[YXButtonCell cellWithReuseIdentifier:@"buttonCell"
													  title:@"Button"
													 target:self
													 action:@selector(buttonCellTapped:)]];
    
    [self setSections:[NSArray arrayWithObjects:sectionA0, sectionA, sectionB, sectionC, nil]];

    [sectionA0 release];
    [sectionA release];
    [sectionB release];
    [sectionC release];

    [super viewDidLoad];
}

#pragma mark - Actions

- (NSNumber*)cell0InitialValue:(YXSwitchCell*)cell {
	return [NSNumber numberWithBool:NO];
}

- (void)cell0:(YXSwitchCell*)cell changedValue:(UISwitch*)switchControl {
	NSLog(@"cell0 changed value to %d", switchControl.on);
}

- (NSNumber*)cell2InitialValue:(YXSwitchCell*)cell {
	return [NSNumber numberWithBool:YES];
}

- (void)cell2:(YXSwitchCell*)cell changedValue:(UISwitch*)switchControl {
	NSLog(@"cell2 changed value to %d", switchControl.on);
}

- (void)cell1Tapped:(YXDisclosureCell*)cell {
	NSLog(@"cell1 tapped");
}

- (void)buttonCellTapped:(YXDisclosureCell*)cell {
	NSLog(@"button cell tapped");
}

- (void)segmentedControlCell:(YXSegmentedControlCell *)cell didChangeValue:(UISegmentedControl *)segmentedControl {
	NSLog(@"Segemented control did change value to %d", segmentedControl.selectedSegmentIndex);
}

- (NSInteger)segmentedControlSelectedIndex:(YXSegmentedControlCell *)cell {
	return 2;
}

@end
