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

#import "FlipViewController.h"

@interface  FlipViewController ()
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic) BOOL displayingFrontView;
@end

@implementation FlipViewController

@synthesize frontView = _frontView;
@synthesize backView = _backView;
@synthesize displayingFrontView = _displayingFrontView;

+ (NSString *)displayName {
	return @"Flip Views";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [[self class] displayName];
    // Set the background color for the window.  The user will see the window's background color on the transition.
	UIColor *backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]];
	[UIApplication sharedApplication].keyWindow.backgroundColor = backgroundColor;
	
	self.frontView = [[UIView alloc] initWithFrame:self.view.bounds];
	self.frontView.backgroundColor = [UIColor colorWithRed:0.345 green:0.349 blue:0.365 alpha:1.000];
	UIImageView *caLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"caLogo.png"]];
	caLogoView.frame = CGRectMake(70, 80, caLogoView.bounds.size.width, caLogoView.bounds.size.height);

	[self.frontView addSubview:caLogoView];
	
	UIImage *backImage = [UIImage imageNamed:@"backView.png"];
	self.backView = [[UIImageView alloc] initWithImage:backImage];
	self.backView.userInteractionEnabled = YES;
	
	[self.view addSubview:self.backView];
	[self.view addSubview:self.frontView];
	
	self.displayingFrontView = YES;
	
	UIGestureRecognizer *frontViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipViews)];
	UIGestureRecognizer *backViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipViews)];
	[self.frontView addGestureRecognizer:frontViewTapRecognizer];
	[self.backView addGestureRecognizer:backViewTapRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];	
}

- (void)flipViews {
	[UIView transitionFromView:(self.displayingFrontView) ? self.frontView : self.backView
						toView:(self.displayingFrontView) ? self.backView : self.frontView
					  duration:0.75 
					   options:(self.displayingFrontView ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft)
					completion:^(BOOL finished) {
						if (finished) {
							self.displayingFrontView = !self.displayingFrontView;
						}
					}];
}

@end
