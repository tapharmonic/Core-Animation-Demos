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

#import "PacmanViewController.h"

@interface PacmanViewController ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIBezierPath *pacmanOpenPath;
@property (nonatomic, strong) UIBezierPath *pacmanClosedPath;
@end

@implementation PacmanViewController

@synthesize shapeLayer = _shapeLayer;
@synthesize pacmanOpenPath = _pacmanOpenPath;
@synthesize pacmanClosedPath = _pacmanClosedPath;

+ (NSString *)displayName {
	return @"CAcman";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [[self class] displayName];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	CGFloat radius = 30.0f;
	CGFloat diameter = radius * 2;
	CGPoint arcCenter = CGPointMake(radius, radius);
	
    // Create a UIBezierPath for Pacman's open state
	self.pacmanOpenPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
															   radius:radius 
														   startAngle:DEGREES_TO_RADIANS(35) 
															 endAngle:DEGREES_TO_RADIANS(315)
															clockwise:YES];	
	[self.pacmanOpenPath addLineToPoint:arcCenter];
	[self.pacmanOpenPath closePath];
	
    // Create a UIBezierPath for Pacman's close state
	self.pacmanClosedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
															   radius:radius 
														   startAngle:DEGREES_TO_RADIANS(1) 
															 endAngle:DEGREES_TO_RADIANS(359) 
															clockwise:YES];
	[self.pacmanClosedPath addLineToPoint:arcCenter];
	[self.pacmanClosedPath closePath];	
	
    // Create a CAself.shapeLayer for Pacman, fill with yellow
	self.shapeLayer = [CAShapeLayer layer];
	self.shapeLayer.fillColor = [UIColor yellowColor].CGColor;
	self.shapeLayer.path = self.pacmanClosedPath.CGPath;
	self.shapeLayer.strokeColor = [UIColor grayColor].CGColor;
	self.shapeLayer.lineWidth = 1.0f;
	self.shapeLayer.bounds = CGRectMake(0, 0, diameter, diameter);
	self.shapeLayer.position = CGPointMake(-40, -100);
	[self.view.layer addSublayer:self.shapeLayer];
	
	SEL startSelector = @selector(startAnimation);
	UIGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:startSelector];
	[self.view addGestureRecognizer:recognizer];
	
    // start animation after short delay
	[self performSelector:startSelector withObject:nil afterDelay:1.0];
}

- (void)startAnimation {

	// Create CHOMP CHOMP animation
	CABasicAnimation *chompAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
	chompAnimation.duration = 0.25;
	chompAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	chompAnimation.repeatCount = HUGE_VALF;
	chompAnimation.autoreverses = YES;
    // Animate between the two path values
	chompAnimation.fromValue = (id)self.pacmanClosedPath.CGPath;
	chompAnimation.toValue = (id)self.pacmanOpenPath.CGPath;
	
	[self.shapeLayer addAnimation:chompAnimation forKey:@"chompAnimation"];
	
	// Create digital '2'-shaped path
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(-40, 100)];
	[path addLineToPoint:CGPointMake(360, 100)];
	[path addLineToPoint:CGPointMake(360, 200)];
	[path addLineToPoint:CGPointMake(-40, 200)];
	[path addLineToPoint:CGPointMake(-40, 300)];
	[path addLineToPoint:CGPointMake(360, 300)];
	
	CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	moveAnimation.path = path.CGPath;
	moveAnimation.duration = 8.0f;
    // Setting the rotation mode ensures Pacman's mouth is always forward.  This is a very convenient CA feature.
	moveAnimation.rotationMode = kCAAnimationRotateAuto;
	[self.shapeLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
}


@end
