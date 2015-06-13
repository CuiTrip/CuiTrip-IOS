//
//  TLImageTransformTool.m
//  Floor21-II
//
//  Created by deng jackie on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETImageTransformTool.h"



@implementation ETImageTransformTool

+ (CGSize)TransformSize:(CGSize)targetSize ScaleToSize:(CGSize)size{
    
    CGSize sizeTarget = targetSize;
    
    float xScale = size.width/sizeTarget.width;
    float yScale = size.height/sizeTarget.height;
    
    float scale = xScale < yScale?xScale:yScale;
    
    sizeTarget.width *= scale;
    sizeTarget.height *= scale;

    return sizeTarget;
}

+ (CGSize)TransformSize:(CGSize)targetSize ScaleToSizeWithMinEdge:(CGSize)size
{
    CGSize sizeTarget = targetSize;
    
    float xScale = size.width/sizeTarget.width;
    float yScale = size.height/sizeTarget.height;
    
    float scale = xScale > yScale?xScale:yScale;
    
    sizeTarget.width *= scale;
    sizeTarget.height *= scale;
    
    return sizeTarget;

}

@end



static CGRect swapWidthAndHeight(CGRect rect)
{
    CGFloat  swap = rect.size.width;
    
    rect.size.width  = rect.size.height;
    rect.size.height = swap;
    
    return rect;
}

@implementation UIImage (WBGImage)

- (UIImage*)rotateWithAvOrientation:(AVCaptureVideoOrientation)orientation{
    return [self rotate:[self avOrientationToImageOrientation:orientation]];
}

- (UIImageOrientation)avOrientationToImageOrientation:(AVCaptureVideoOrientation)orientation{
    
    switch (orientation) {
		case AVCaptureVideoOrientationLandscapeLeft:{
                
            return  UIImageOrientationUp;
        }
			break;
            
		case AVCaptureVideoOrientationLandscapeRight:{
            
            return  UIImageOrientationDown;
        }
            
			break;
            
		case AVCaptureVideoOrientationPortraitUpsideDown:{

            return UIImageOrientationLeft;
        }
            
		default:{
            
			return UIImageOrientationRight;
            
        }
			break;
	}
}

-(UIImage*)rotate:(UIImageOrientation)orient
{
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGImageRef         imag = self.CGImage;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    rect.size.width  = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orient)
    {
        case UIImageOrientationUp:
            // would get you an exact copy of the original
            //assert(false);
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

- (UIImage*)tranformScaleToSize:(CGSize)size{
    
    float scale = 1.0;
    
    //if(size.width < self.size.width)
    {
        
        scale = size.width/self.size.width;
    }
    
    //if(size.height < self.size.height)
    {
        
        float tempScale = size.height/self.size.height;
        
        if(tempScale < scale){
            scale = tempScale;
        }
    }
    
    size = self.size;
    size.width *= scale;
    size.height *= scale;
    
    UIImage * resultImage = nil;
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(-2,-2, size.width+4, size.height+4)];
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
    
}

- (UIImage*)UIImageScaleToWidth640:(UIImage*)image{
    
    if(image.size.width < 640)return image;
    
    float scale = 640.0/image.size.width;
    
    CGSize size = image.size;
    
    size.width *= scale;
    size.height *= scale;
    
    UIImage * result = nil;
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(-1,-1, size.width+2, size.height+2)];
    
    result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSLog(@"size =%@",NSStringFromCGSize(result.size));
    
    return result;
}

- (UIImage*)tranformToOpenGLRGBA{
    
    UIImage * image = nil;
    UIGraphicsBeginImageContext(self.size);
    [self drawAtPoint:CGPointZero];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)UIImage:(UIImage *)image scaleToMinSize:(float)size
{
    if(image.size.width <= size || image.size.height <= size)return image;
    
    float scale = image.size.width > image.size.height?image.size.height:image.size.width;
    
    scale = size/scale;
    
    CGRect drawRect;
    drawRect.size = image.size;
    
    drawRect.size.width *= scale;
    drawRect.size.height *= scale;
    
    UIImage * resultImage = nil;

    UIGraphicsBeginImageContext(drawRect.size);
    
    [image drawInRect:drawRect];
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}


+ (UIImage*)UIImage:(UIImage*)image scaleToSize:(CGSize)size{
    
    CGSize sizeTarget = image.size;
    UIImage * imageReturn = image;
    
    //NSLog(@"%@",NSStringFromCGSize(image.size));
    
    if(sizeTarget.width > size.width || sizeTarget.height > size.height){
        
        float xScale = size.width/sizeTarget.width;
        float yScale = size.height/sizeTarget.height;
        
        float scale = xScale < yScale?xScale:yScale;
        
        sizeTarget.width *= scale;
        sizeTarget.height *= scale;
        
        float xEdge = 5;
        float yEdge = (5/sizeTarget.width)*sizeTarget.height;
        
        CGRect drawRect = CGRectMake(-xEdge,
                                     -yEdge,
                                     sizeTarget.width+xEdge*2,
                                     sizeTarget.height+yEdge*2);
        
        UIGraphicsBeginImageContext(sizeTarget);
        
        [[UIColor blackColor] setFill];
        
          UIRectFill(drawRect);
        
        [image drawInRect:drawRect];
        
        imageReturn = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return imageReturn;
}

+ (UIImage*)UIImageScaleTo640:(UIImage*)image
{
    return [UIImage UIImage:image
                scaleToSize:CGSizeMake(640, 640)];
}

+ (UIImage*)UIImage:(UIImage *)image scaleToSizeWithCenterCut:(CGSize)size{
    
    //    size.width *= [TMUtils getUIScreenScale];
    //    size.height *= [TMUtils getUIScreenScale];
    
    CGSize sizeTarget = image.size;
    UIImage * imageReturn = nil;
    
    float xScale = size.width/sizeTarget.width;
    float yScale = size.height/sizeTarget.height;
    
    float scale = xScale > yScale?xScale:yScale;
    
    sizeTarget.width *= scale;
    sizeTarget.height *= scale;
    
    float xOffset = (size.width - sizeTarget.width)/2;
    float yOffset = (size.height - sizeTarget.height)/2;
    
    CGRect drawRect = CGRectMake(xOffset, yOffset, sizeTarget.width,sizeTarget.height);
    
    UIGraphicsBeginImageContext(size);
    
    [[UIColor redColor] setFill];
    
    [image drawInRect:drawRect];
    
    imageReturn = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageReturn;
    
}



+ (UIImage*)UIImageMakeCenterCut:(UIImage *)image{
    
    float width = image.size.width > image.size.height?image.size.height:image.size.width;
    
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    drawRect.origin.x = (width - image.size.width)/2;
    drawRect.origin.y = (width - image.size.height)/2;
    
    UIImage * targetImage = nil;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    
    [image drawInRect:drawRect];
    targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}

+ (UIImage*)UIImageMakeCenterRound:(UIImage*)image{
    
    UIImage * targetImage = [self UIImageMakeCenterCut:image];
    
    UIGraphicsBeginImageContext(targetImage.size);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),[[UIBezierPath bezierPathWithArcCenter:CGPointMake(targetImage.size.width/2, targetImage.size.height/2)
                                                                                   radius:targetImage.size.width/2
                                                                               startAngle:0
                                                                                 endAngle:2*M_PI
                                                                                clockwise:NO] CGPath]);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [targetImage drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return targetImage;
}

+ (UIImage*)handleLargeImage:(UIImage*) originalImage//用来处理变态图，如全景图，长图等，压缩和旋转操作,宽图需要旋转
{
    
    if (originalImage == nil)
    {
        return nil;
    }
    
    CGSize size = [originalImage size];
    CGSize newSize = size;
    CGFloat whRatio = size.width / size.height;
    
    int minSideLength = 640;
    
    if(size.width > minSideLength || size.height > minSideLength)
    {
        if(whRatio > 1.f)
        {
            newSize.width = minSideLength * whRatio;;
            newSize.height = minSideLength;
        }
        else
        {
            newSize.height = minSideLength/whRatio;
            newSize.width = minSideLength;
        }
    }
    
    
    UIImage* resultImage = nil;
    resultImage  = [originalImage tranformScaleToSize:newSize];
    
    if (whRatio>=2.f)//宽图一张
    {
        resultImage = [resultImage rotate: UIImageOrientationRight];
    }
    
    return resultImage;
}


@end

@implementation UIColor (UIColor)

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}

@end