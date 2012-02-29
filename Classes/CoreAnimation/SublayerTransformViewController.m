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

#import "SublayerTransformViewController.h"

@interface SublayerTransformViewController ()
@property (nonatomic, strong) CALayer *rootLayer;
@end

@implementation SublayerTransformViewController

@synthesize rootLayer = _rootLayer;

+ (NSString *)displayName {
	return @"Sublayer Transforms";
}

- (void)addLayersWithColors:(NSArray *)colors {

	for (UIColor *color in colors) {
		CALayer *layer = [CALayer layer];
		layer.backgroundColor = color.CGColor;
		layer.bounds = CGRectMake(0, 0, 200, 200);
		layer.position = CGPointMake(160, 170);
		layer.opacity = 0.65;
		layer.cornerRadius = 10;
		layer.borderColor = [UIColor whiteColor].CGColor;
		layer.borderWidth = 1.0;
		layer.shadowOffset = CGSizeMake(0, 2);
		layer.shadowOpacity = 0.35;
		layer.shadowColor = [UIColor darkGrayColor].CGColor;
		layer.shouldRasterize = YES;
		[self.rootLayer addSublayer:layer];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [[self class] displayName];
    
	self.rootLayer = [CALayer layer];
    // Apply perspective transform
	self.rootLayer.sublayerTransform = CATransform3DMakePerspective(1000);
	self.rootLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:self.rootLayer];
	
	NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor purpleColor], nil];
	[self addLayersWithColors:colors];
	
	[self performSelector:@selector(rotateLayers) withObject:nil afterDelay:1.0];
}

- (void)rotateLayers {
    
    // Create basic animation to rotate around the Y and Z axes
	CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(85), 0, 1, 1)];
	transformAnimation.duration = 1.5;
	transformAnimation.autoreverses = YES;
	transformAnimation.repeatCount = HUGE_VALF;
	transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	int tx = 0;
    // Loop through the sublayers and attach the animations
	for (CALayer *layer in [self.rootLayer sublayers]) {
		[layer addAnimation:transformAnimation forKey:nil];
		
        // Create animation to translate along the X axis
		CABasicAnimation *translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
		translateAnimation.fromValue = [NSValue valueWithCATransform3D:layer.transform];
		translateAnimation.toValue = [NSNumber numberWithFloat:tx];
		translateAnimation.duration = 1.5;
		translateAnimation.autoreverses = YES;
		translateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		translateAnimation.repeatCount = HUGE_VALF;
		[layer addAnimation:translateAnimation forKey:nil];
		tx += 35;
	}
}

@end
