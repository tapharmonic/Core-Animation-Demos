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

#import "FlipViewController.h"

@implementation FlipViewController

+ (NSString *)displayName {
	return @"Flip Views";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [[self class] displayName];
    // Set the background color for the window.  The user will see the window's background color on the transition.
	UIColor *backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]];
	[UIApplication sharedApplication].keyWindow.backgroundColor = backgroundColor;
	
	frontView = [[UIView alloc] initWithFrame:self.view.bounds];
	frontView.backgroundColor = [UIColor colorWithRed:0.345 green:0.349 blue:0.365 alpha:1.000];
	UIImageView *caLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"caLogo.png"]];
	caLogoView.frame = CGRectMake(70, 80, caLogoView.bounds.size.width, caLogoView.bounds.size.height);

	[frontView addSubview:caLogoView];
	
	UIImage *backImage = [UIImage imageNamed:@"backView.png"];
	backView = [[UIImageView alloc] initWithImage:backImage];
	backView.userInteractionEnabled = YES;
	
	[self.view addSubview:backView];
	[self.view addSubview:frontView];
	
	displayingFrontView = YES;
	
	UIGestureRecognizer *frontViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipViews)];
	UIGestureRecognizer *backViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipViews)];
	[frontView addGestureRecognizer:frontViewTapRecognizer];
	[backView addGestureRecognizer:backViewTapRecognizer];
	[frontViewTapRecognizer release];
	[backViewTapRecognizer release];
}

- (void)flipViews {
	[UIView transitionFromView:(displayingFrontView) ? frontView : backView
						toView:(displayingFrontView) ? backView : frontView
					  duration:0.75 
					   options:(displayingFrontView ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft)
					completion:^(BOOL finished) {
						if (finished) {
							displayingFrontView = !displayingFrontView;
						}
					}];
}

- (void)dealloc {
	[frontView release];
	[backView release];
	[UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    [super dealloc];
}


@end
