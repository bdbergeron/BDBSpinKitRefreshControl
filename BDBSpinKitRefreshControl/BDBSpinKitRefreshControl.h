//
//  BDBSpinKitRefreshControl.h
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

@import UIKit;

#import <SpinKit/RTSpinKitView.h>


#pragma mark -
/**
 *  Delegate for BDBSpinKitRefreshControl
 *
 *  @since 1.0.1
 */
@protocol BDBSpinKitRefreshControlDelegate
<NSObject>

@optional
/**
 *  Delegate method called once the refresh control has been displayed.
 *
 *  @since 1.0.1
 */
- (void)didShowRefreshControl;

/**
 *  Delegate method called once the refresh control has been hidden.
 *
 *  @since 1.0.1
 */
- (void)didHideRefreshControl;

@end


/**
 *  BDBSpinKitRefreshControl is a drop-in replacement for UIRefreshControl that utilizes
 *  the fantastic SpinKit (https://github.com/tobiasahlin/SpinKit) progress indicators.
 *
 *  @since 1.0.0
 */
#pragma mark -
@interface BDBSpinKitRefreshControl : UIRefreshControl

#pragma mark Properties
/**
 *  ---------------------------------------------------------------------------------------
 *  @name Properties
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  Delegate that implements methods described in BDBSpinKitRefreshControlDelegate.
 *
 *  @since 1.0.1
 */
@property (nonatomic, weak) id <BDBSpinKitRefreshControlDelegate> delegate;

/**
 *  The underlying RTSpinKitView that replaces the default UIActivityIndicator.
 *
 *  @since 1.0.0
 */
@property (nonatomic, readonly) RTSpinKitView *spinner;

/**
 *  Tint color of the spinner.
 *
 *  @discussion This property overrides the default implemetation of tintColor in 
 *              UIRefreshControl in order to prevent the default UIActivityIndicator from
 *              becoming visible when changing the tint color.
 *
 *  @since 1.0.1
 */
@property (nonatomic) UIColor *tintColor;

/**
 *  When set to YES, the underlying RTSpinKitView will change color instantaneously.
 *  Otherwise, any color change will take effect the next time the spinner is shown.
 *  Default value is NO.
 *
 *  @since 1.0.1
 */
@property (nonatomic, assign) BOOL shouldChangeColorInstantly;


#pragma mark Initialization
/**
 *  ---------------------------------------------------------------------------------------
 *  @name Initialization
 *  ---------------------------------------------------------------------------------------
 */

/**
 *  Initialize a new BDBSpinKitRefreshControl instance with the specified style and color.
 *
 *  @param style RTSpinKitViewStyle that the refresh control should use.
 *  @param color Color applied to the underlying RTSpinKitView.
 *
 *  @return New BDBSpinKitRefreshControl instance.
 *
 *  @since 1.0.0
 */
+ (instancetype)refreshControlWithStyle:(RTSpinKitViewStyle)style
                                  color:(UIColor *)color;

/**
 *  Initialize a new BDBSpinKitRefreshControl instance with the specified style and color.
 *
 *  @param style RTSpinKitViewStyle that the refresh control should use.
 *  @param color Color applied to the underlying RTSpinKitView.
 *
 *  @return New BDBSpinKitRefreshControl instance.
 *
 *  @since 1.0.0
 */
- (instancetype)initWithStyle:(RTSpinKitViewStyle)style
                        color:(UIColor *)color;

@end
