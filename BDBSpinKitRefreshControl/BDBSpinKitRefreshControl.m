//
//  BDBSpinKitRefreshControl.m
//
//  Copyright (c) 2014 Bradley David Bergeron
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "BDBSpinKitRefreshControl.h"

static void * const kBDBSpinKitRefreshControlKVOContext = (void *)&kBDBSpinKitRefreshControlKVOContext;
static NSString * const kHidden = @"hidden";

#pragma mark -
@interface BDBSpinKitRefreshControl ()

@property (nonatomic) UIColor *color;

@end

#pragma mark -
@implementation BDBSpinKitRefreshControl

+ (instancetype)refreshControlWithStyle:(RTSpinKitViewStyle)style color:(UIColor *)color {
    return [[[self class] alloc] initWithStyle:style color:color];
}

- (id)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor *)color {
    self = [super init];

    if (self) {
        super.tintColor = [UIColor clearColor];

        _spinner = [[RTSpinKitView alloc] initWithStyle:style color:color];

        _color = color;
        _shouldChangeColorInstantly = false;

        [super addObserver:self
                forKeyPath:kHidden
                   options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                   context:kBDBSpinKitRefreshControlKVOContext];
    }

    return self;
}

- (void)dealloc
{
    @try {
        [super removeObserver:self
                   forKeyPath:kHidden
                      context:kBDBSpinKitRefreshControlKVOContext];
    }
    @catch (NSException * __unused exception) {}
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    if (self.spinner.superview) {
        [self.spinner removeFromSuperview];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    UIView *modernContentView = self.subviews.lastObject;
    UIView *containerView = modernContentView.subviews.firstObject;

    if (containerView) {
        [containerView removeFromSuperview];
    }

    [modernContentView addSubview:self.spinner];
    self.spinner.center = modernContentView.center;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kBDBSpinKitRefreshControlKVOContext) {
        if ([object isKindOfClass:[self class]]) {
            if ([keyPath isEqualToString:kHidden]) {
                BOOL isHidden = [change[NSKeyValueChangeOldKey] boolValue];
                BOOL willHide = [change[NSKeyValueChangeNewKey] boolValue];

                if (isHidden && !willHide) {
                    self.spinner.color = self.color;
                    [self.spinner startAnimating];

                    if ([self.delegate respondsToSelector:@selector(didShowRefreshControl)]) {
                        [self.delegate didShowRefreshControl];
                    }
                } else if (!isHidden && willHide) {
                    [self.spinner stopAnimating];

                    if ([self.delegate respondsToSelector:@selector(didHideRefreshControl)]) {
                        [self.delegate didHideRefreshControl];
                    }
                }
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setTintColor:(UIColor *)color {
    _color = color;

    if (self.shouldChangeColorInstantly || self.spinner.hidden) {
        self.spinner.color = color;
    }
}

- (UIColor *)tintColor {
    return self.color;
}

@end
