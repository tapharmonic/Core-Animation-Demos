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

#import "StickyNotesViewController.h"
#import "NoteView.h"

@implementation StickyNotesViewController

@synthesize noteView = _noteView;
@synthesize nextText = _nextText;

+ (NSString *)displayName {
	return @"Sticky Notes";
}

- (void)viewDidLoad {
    [super viewDidLoad];    
	self.title = [[self class] displayName];
	self.noteView = [[NoteView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)];
	self.noteView.delegate = self;
	self.noteView.text = @"A computer once beat me at chess, but it was no match for me at kick boxing.\n-Emo Philips";
	self.nextText = @"A lot of people are afraid of heights. Not me, I'm afraid of widths.\n-Steven Wright";
	
	UIImage *corkboard = [UIImage imageNamed:@"corkboard.png"];
	self.view.backgroundColor = [UIColor colorWithPatternImage:corkboard];

    // Shadow needs to be applied to the containing layer so it doesn't blip when the animation occurs.
    // Hat tip to Troy for pointing that out!
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 300)];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.layer.shadowOffset = CGSizeMake(0, 2);
    containerView.layer.shadowOpacity = 0.80;
    [containerView addSubview:self.noteView];
	[self.view addSubview:containerView];
}

- (void)addNoteTapped {
	[UIView transitionWithView:self.noteView duration:0.6
					   options:UIViewAnimationOptionTransitionCurlUp
					animations:^{
						NSString *currentText = self.noteView.text;
						self.noteView.text = self.nextText;
						self.nextText = currentText;
					} completion:^(BOOL finished){
						
					}];
}


@end
