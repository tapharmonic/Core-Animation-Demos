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

#import "BatmanViewController.h"

#define ROTATE_LEFT_TAG	 3
#define ROTATE_RIGHT_TAG 4

@interface BatmanViewController ()
@property (nonatomic, strong) CALayer *logoLayer;
@end

@implementation BatmanViewController

@synthesize logoLayer = _logoLayer;

- (id)init {
    self = [super initWithNibName:@"BatmanView" bundle:nil];
    return self;
}

+ (NSString *)displayName {
	return @"I'm Batman";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor blackColor];
	self.title = [[self class] displayName];
	
	UIImage *image = [UIImage imageNamed:@"batman.png"];
	
	self.logoLayer = [CALayer layer];
	self.logoLayer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
	self.logoLayer.position = CGPointMake(160, 180);
	self.logoLayer.contents = (id)image.CGImage;
	
	// Add layer as a sublayer of the UIView's layer
	[self.view.layer addSublayer:self.logoLayer];
}

- (IBAction)rotate:(id)sender {
	int direction = [sender tag] == ROTATE_LEFT_TAG ? -1 : 1;
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * direction];
	rotationAnimation.duration = 1.0f;
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[self.logoLayer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
}

- (void)scaleByFactor:(CGFloat)factor {
	CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    NSNumber *scaleFactor = [NSNumber numberWithFloat:factor];
	scaleAnimation.toValue = scaleFactor;
	scaleAnimation.duration = 3.0f;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // Set the model layer's property so the animation sticks at the 'toValue' state
	[self.logoLayer setValue:scaleFactor forKeyPath:@"transform.scale"];
	[self.logoLayer addAnimation:scaleAnimation forKey:@"transformAnimation"];
}

- (IBAction)scaleDown {
	CGFloat factor = [[self.logoLayer valueForKeyPath:@"transform.scale"] floatValue] > 1.0 ? 1.0 : 0.5;
	[self scaleByFactor:factor];
}

- (IBAction)scaleUp {
	CGFloat factor = [[self.logoLayer valueForKeyPath:@"transform.scale"] floatValue] == 0.5 ? 1.0 : 1.5;
	[self scaleByFactor:factor];
}

// Combine scale and rotate transform into group.  Let animation group repeat indefinitely
- (IBAction)doBatmanAnimation {
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3]; // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
	rotationAnimation.duration = 1.9f;
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
	scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
	scaleAnimation.duration = 2.0f;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 2.0f;
	animationGroup.autoreverses = YES;
	animationGroup.repeatCount = HUGE_VALF;
	[animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];

	[self.logoLayer addAnimation:animationGroup forKey:@"animationGroup"];
}

@end
