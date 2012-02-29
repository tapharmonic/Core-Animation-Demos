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

#import "PulseViewController.h"

@implementation PulseViewController

+ (NSString *)displayName {
	return @"Pulse";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [[self class] displayName];
	
	UIImage *image = [UIImage imageNamed:@"heart.png"];
	CALayer *layer = [CALayer layer];
	layer.contents = (id)image.CGImage;
	layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
	layer.position = CGPointMake(160, 200);

	// Shrink down to 90% of its original value
	layer.transform = CATransform3DMakeScale(0.90, 0.90, 1);
	
	[self.view.layer addSublayer:layer];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animation.autoreverses = YES;
	animation.duration = 0.35;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = HUGE_VALF;
	[layer addAnimation:animation forKey:@"pulseAnimation"];
}

@end
