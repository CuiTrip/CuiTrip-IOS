//
//  TLImageTransformTool.h
//  Floor21-II
//
//  Created by deng jackie on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>

@interface ETImageTransformTool : NSObject

+ (CGSize)TransformSize:(CGSize)targetSize ScaleToSize:(CGSize)size;
+ (CGSize)TransformSize:(CGSize)targetSize ScaleToSizeWithMinEdge:(CGSize)size;
@end

@interface UIColor (UIColor)
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;
@end

@interface UIImage (WBGImage)

- (UIImage*)rotate:(UIImageOrientation)orient;
- (UIImageOrientation)avOrientationToImageOrientation:(AVCaptureVideoOrientation)orientation;
- (UIImage*)rotateWithAvOrientation:(AVCaptureVideoOrientation)orientation;
- (UIImage*)tranformScaleToSize:(CGSize)size;

- (UIImage*)tranformToOpenGLRGBA;
- (UIImage*)UIImageScaleToWidth640:(UIImage*)image;
+ (UIImage*)UIImageScaleTo640:(UIImage*)image;
+ (UIImage*)UIImageMakeCenterCut:(UIImage *)image;

+ (UIImage*)UIImageMakeCenterRound:(UIImage*)image;

//按最长边来缩放
+ (UIImage*)UIImage:(UIImage*)image scaleToSize:(CGSize)size;
//按最短边来缩放
+ (UIImage*)UIImage:(UIImage *)image scaleToMinSize:(float)size;
+ (UIImage*)UIImage:(UIImage *)image scaleToSizeWithCenterCut:(CGSize)size;
+ (UIImage*)handleLargeImage:(UIImage*) originalImage;

@end

