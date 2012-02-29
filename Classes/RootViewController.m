//
//  MIT License
//
//  Copyright (c) 2012 Bob McCune http://bobmccune.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RootViewController.h"

#import "TachometerViewController.h"
#import "BatmanViewController.h"
#import "PacmanViewController.h"
#import "ImplicitAnimationsViewController.h"
#import "CharlieViewController.h"
#import "SimpleViewPropertyAnimation.h"
#import "StickyNotesViewController.h"
#import "AVPlayerLayerViewController.h"
#import "ReflectionViewController.h"
#import "FlipViewController.h"
#import "PulseViewController.h"
#import "MakeItStickViewController.h"
#import "SublayerTransformViewController.h"

@interface UIViewController ()
@property (nonatomic, strong) NSMutableArray *items;
+ (NSString *)displayName;
@end

@implementation RootViewController

@synthesize items = _items;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.items = [[NSMutableArray alloc] init];
	
	NSMutableArray *layersList = [NSMutableArray array];
	[layersList addObject:[ImplicitAnimationsViewController class]];
	[layersList addObject:[MakeItStickViewController class]];
	[layersList addObject:[TachometerViewController class]];
	[layersList addObject:[BatmanViewController class]];
	[layersList addObject:[PacmanViewController class]];
	[layersList addObject:[SublayerTransformViewController class]];
	[layersList addObject:[AVPlayerLayerViewController class]];
	[layersList addObject:[CharlieViewController class]];
	[layersList addObject:[ReflectionViewController class]];
	[layersList addObject:[PulseViewController class]];

	NSDictionary *layers = [NSDictionary dictionaryWithObject:layersList forKey:@"Core Animation"];
	[self.items addObject:layers];
	
	NSMutableArray *uiKitList = [NSMutableArray array];
	[uiKitList addObject:[SimpleViewPropertyAnimation class]];
	[uiKitList addObject:[StickyNotesViewController class]];
	[uiKitList addObject:[FlipViewController class]];

	
	NSDictionary *uiKits = [NSDictionary dictionaryWithObject:uiKitList forKey:@"UIKit Animation"];
	[self.items addObject:uiKits];
	
	self.title = @"Animations";
}

#pragma mark -
#pragma mark Table view data source

- (NSArray *)valuesForSection:(NSUInteger)section {
	NSDictionary *dictionary = [self.items objectAtIndex:section];
	NSString *key = [[dictionary allKeys] objectAtIndex:0];
	return [dictionary objectForKey:key];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[[self.items objectAtIndex:section] allKeys] objectAtIndex:0];	
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self valuesForSection:section] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	
	NSArray *values = [self valuesForSection:indexPath.section];
	cell.textLabel.text = [[values objectAtIndex:indexPath.row] displayName];
	
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *values = [self valuesForSection:indexPath.section];
	Class clazz = [values objectAtIndex:indexPath.row];
	id controller = [[clazz alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

@end
