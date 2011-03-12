//
//  MIT License
//
//  Copyright (c) 2011 Bob McCune http://bobmccune.com/
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

#import "ImplicitAnimationsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CALayer+Additions.h"

#define ORGINAL_POSITION CGPointMake(160, 250)
#define MOVED_POSITON CGPointMake(200, 290)

@implementation ImplicitAnimationsViewController

+ (NSString *)displayName {
	return @"Animatable Properties";
}

- (id)init {
	if ((self = [super initWithNibName:@"LayerView" bundle:nil])) {
		layer = [CALayer layer];
		layer.bounds = CGRectMake(0, 0, 200, 200);
		layer.position = CGPointMake(160, 250);
		layer.backgroundColor = [UIColor redColor].CGColor;
		layer.borderColor = [UIColor blackColor].CGColor;
		layer.opacity = 1.0f;
		[self.view.layer addSublayer:layer];		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.actionsSwitch.on = NO;
	self.title = [[self class] displayName];
}

- (IBAction)toggleColor {
	[CATransaction setDisableActions:actionsSwitch.on];
	CGColorRef redColor = [UIColor redColor].CGColor, blueColor = [UIColor blueColor].CGColor;
	layer.backgroundColor = (layer.backgroundColor == redColor) ? blueColor : redColor;
}

- (IBAction)toggleCornerRadius {
	[CATransaction setDisableActions:actionsSwitch.on];
	layer.cornerRadius = (layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
}

- (IBAction)toggleBorder {
	[CATransaction setDisableActions:actionsSwitch.on];
	layer.borderWidth = (layer.borderWidth == 0.0f) ? 10.0f : 0.0f;
}

- (IBAction)toggleOpacity {
	[CATransaction setDisableActions:actionsSwitch.on];
	layer.opacity = (layer.opacity == 1.0f) ? 0.5f : 1.0f;
}

- (IBAction)toggleBounds {
	[CATransaction setDisableActions:actionsSwitch.on];
    [layer adjustWidthBy:layer.bounds.size.width == layer.bounds.size.height ? 100 : -100];
}

- (IBAction)togglePosition {
	[CATransaction setDisableActions:actionsSwitch.on];
	layer.position = layer.position.x == 160 ? MOVED_POSITON : ORGINAL_POSITION;
}

@synthesize actionsSwitch;

@end
