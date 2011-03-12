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

#import "SimpleViewPropertyAnimation.h"


@implementation SimpleViewPropertyAnimation

+ (NSString *)displayName {
	return @"Block-based Animations";
}

- (UIGestureRecognizer *)createTapRecognizerWithSelector:(SEL)selector {
    return [[[UITapGestureRecognizer alloc] initWithTarget:self action:selector] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [[self class] displayName];
    
    fadeMeView = [[UIView alloc] initWithFrame:CGRectMake(55, 40, 210, 160)];
    fadeMeView.backgroundColor = [UIColor colorWithRed:0.580 green:0.706 blue:0.796 alpha:1.000];
    [self.view addSubview:fadeMeView];
    
    moveMeView = [[UIView alloc] initWithFrame:CGRectMake(55, 220, 210, 160)];
    moveMeView.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    [self.view addSubview:moveMeView];
                  
	[fadeMeView addGestureRecognizer:[self createTapRecognizerWithSelector:@selector(fadeMe)]];
	[moveMeView addGestureRecognizer:[self createTapRecognizerWithSelector:@selector(moveMe)]];
}

- (void)fadeMe {
	[UIView animateWithDuration:1.0 animations:^{
		fadeMeView.alpha = 0.0f;	
	}];
}

- (void)moveMe {
	[UIView animateWithDuration:0.5 animations:^{
		moveMeView.center = CGPointMake(moveMeView.center.x, moveMeView.center.y - 200);	
	}];
}

- (void)dealloc {
    CARelease(fadeMeView);
    CARelease(moveMeView);
    [super dealloc];
}

@end
