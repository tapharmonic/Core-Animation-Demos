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

#import "MakeItStickViewController.h"

@interface MakeItStickViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation MakeItStickViewController

@synthesize layer = _layer;

+ (NSString *)displayName {
	return @"Make it Stick";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [[self class] displayName];
	UIImage *image = [UIImage imageNamed:@"heart"];
	self.layer = [CALayer layer];
	self.layer.contents = (id)image.CGImage;
	self.layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
	self.layer.position = CGPointMake(160, 200);
	[self.view.layer addSublayer:self.layer];
		
	UIGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fadeIt)];
	[self.view addGestureRecognizer:recognizer];
}

- (void)fadeIt {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.toValue = [NSNumber numberWithFloat:0.0];
	animation.fromValue = [NSNumber numberWithFloat:self.layer.opacity];
	animation.duration = 1.0;
	self.layer.opacity = 0.0; // This is required to update the model's value.  Comment out to see what happens.
	[self.layer addAnimation:animation forKey:@"animateOpacity"];
}

@end
