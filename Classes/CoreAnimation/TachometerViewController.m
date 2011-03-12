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

#import "TachometerViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation TachometerViewController

+ (NSString *)displayName {
	return @"Start Me Up";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [[self class] displayName];
	
    // The animation was fun without the audio, but it's WAY better with the engine rev sound.
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"engine" ofType:@"caf"]];
	self.audioPlayer = [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] autorelease];
	[self.audioPlayer prepareToPlay];	
	
	UIImage *image = [UIImage imageNamed:@"metalbackground.png"];
	self.view.backgroundColor = [UIColor colorWithPatternImage:image];
	
    // Create the tach's background layer
	tachLayer = [CALayer layer];
	tachLayer.bounds = CGRectMake(0, 0, 300, 300);
	tachLayer.position = CGPointMake(160, 200);
	tachLayer.contents = (id)[UIImage imageNamed:@"speed.png"].CGImage;
	[self.view.layer addSublayer:tachLayer];
	
    // Create the layer for the pin
	pinLayer = [CALayer layer];
	pinLayer.bounds = CGRectMake(0, 0, 72, 54);
	pinLayer.contents = (id)[UIImage imageNamed:@"pin.png"].CGImage;
	pinLayer.position = CGPointMake(150, 150);
	pinLayer.anchorPoint = CGPointMake(1.0, 1.0);
    // Rotate to the left 50 degrees so it lines up with the 0 position on the gauge
	pinLayer.transform = CATransform3DRotate(pinLayer.transform, DEGREES_TO_RADIANS(-50), 0, 0, 1);
	[tachLayer addSublayer:pinLayer];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Rev It!" forState:UIControlStateNormal];
	button.frame = CGRectMake(230, 20, 80, 31);
	[button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}

- (void)go:(id)sender {
	[self.audioPlayer play];
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(160))];
	rotationAnimation.duration = 1.0f;
	rotationAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[pinLayer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}

- (void)dealloc {
	self.audioPlayer = nil;
	[super dealloc];
}

@synthesize audioPlayer;

@end
