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

#import "ImplicitAnimationsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CALayer+Additions.h"

#define ORGINAL_POSITION CGPointMake(160, 250)
#define MOVED_POSITON CGPointMake(200, 290)

@interface ImplicitAnimationsViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation ImplicitAnimationsViewController

@synthesize actionsSwitch = _actionsSwitch;
@synthesize layer = _layer;

+ (NSString *)displayName {
	return @"Animatable Properties";
}

- (id)init {
	if ((self = [super initWithNibName:@"LayerView" bundle:nil])) {
		self.layer = [CALayer layer];
		self.layer.bounds = CGRectMake(0, 0, 200, 200);
		self.layer.position = CGPointMake(160, 250);
		self.layer.backgroundColor = [UIColor redColor].CGColor;
		self.layer.borderColor = [UIColor blackColor].CGColor;
		self.layer.opacity = 1.0f;
		[self.view.layer addSublayer:self.layer];		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.actionsSwitch.on = NO;
	self.title = [[self class] displayName];
}

- (IBAction)toggleColor {
	[CATransaction setDisableActions:self.actionsSwitch.on];
	CGColorRef redColor = [UIColor redColor].CGColor, blueColor = [UIColor blueColor].CGColor;
	self.layer.backgroundColor = (self.layer.backgroundColor == redColor) ? blueColor : redColor;
}

- (IBAction)toggleCornerRadius {
	[CATransaction setDisableActions:self.actionsSwitch.on];
	self.layer.cornerRadius = (self.layer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
}

- (IBAction)toggleBorder {
	[CATransaction setDisableActions:self.actionsSwitch.on];
	self.layer.borderWidth = (self.layer.borderWidth == 0.0f) ? 10.0f : 0.0f;
}

- (IBAction)toggleOpacity {
	[CATransaction setDisableActions:self.actionsSwitch.on];
	self.layer.opacity = (self.layer.opacity == 1.0f) ? 0.5f : 1.0f;
}

- (IBAction)toggleBounds {
	[CATransaction setDisableActions:self.actionsSwitch.on];
    [self.layer adjustWidthBy:self.layer.bounds.size.width == self.layer.bounds.size.height ? 100 : -100];
}

- (IBAction)togglePosition {
	[CATransaction setDisableActions:self.actionsSwitch.on];
	self.layer.position = self.layer.position.x == 160 ? MOVED_POSITON : ORGINAL_POSITION;
}

@end
