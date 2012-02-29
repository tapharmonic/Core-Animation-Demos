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

#import "AVPlayerLayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation AVPlayerLayerViewController

@synthesize player = _player;

+ (NSString *)displayName {
	return @"Amazon Babe";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [[self class] displayName];
	self.view.backgroundColor = [UIColor darkGrayColor];
	
	// Setup AVPlayer
    // Hilarious video from the guys at http://www.thekeyofawesome.com/
	NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"cyborg" ofType:@"m4v"];
	self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:moviePath]];
	[self.player play];
	
	// Create and configure AVPlayerLayer
	AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
	playerLayer.bounds = CGRectMake(0, 0, 300, 170);
	playerLayer.position = CGPointMake(160, 150);
	playerLayer.borderColor = [UIColor whiteColor].CGColor;
	playerLayer.borderWidth = 3.0;
	playerLayer.shadowOffset = CGSizeMake(0, 3);
	playerLayer.shadowOpacity = 0.80;

    // Add perspective transform
	self.view.layer.sublayerTransform = CATransform3DMakePerspective(1000);	
	[self.view.layer addSublayer:playerLayer];
	
    // Set up slider used to rotate video around Y-axis
	UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(60, 300, 200, 23)];
	slider.minimumValue = -1.0;
	slider.maximumValue = 1.0;
	slider.continuous = NO;
	slider.value = 0.0;
	[slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchDragInside];
	[self.view addSubview:slider];

    // Spin button to spin the video around the X-axis
	UIButton *spinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	spinButton.frame = CGRectMake(0, 0, 50, 31);
	spinButton.center = CGPointMake(160, 350);
	[spinButton setTitle:@"Spin" forState:UIControlStateNormal];
	[spinButton addTarget:self action:@selector(spinIt) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:spinButton];
	
}

// Rotate the layer around the Y-axis as slider value is changed
-(IBAction)sliderValueChanged:(UISlider *)sender{
	CALayer *layer = [[self.view.layer sublayers] objectAtIndex:0];
	layer.transform = CATransform3DMakeRotation([sender value], 0, 1, 0);
}

// Animate spinning video around X-axis
- (void)spinIt {
	CALayer *layer = [[self.view.layer sublayers] objectAtIndex:0];
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	animation.duration = 1.25f;
	animation.toValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(360)];
	[layer addAnimation:animation forKey:@"spinAnimation"];
}

- (void)dealloc {
	[self.player pause];
}

@end
