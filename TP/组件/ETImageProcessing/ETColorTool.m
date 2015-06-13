//
//  WBGColorTool.m
//  ColorTouch
//
//  Created by jackiedeng on 13-5-29.
//  Copyright (c) 2013年 jackiedeng. All rights reserved.
//

#import "ETColorTool.h"

@implementation ETColorTool

+ (NSArray *)colorSumFromImage:(UIImage*)image totalLevel:(int)level
{
    CGImageRef cgImage = [image CGImage];
    
    int width = CGImageGetWidth([image CGImage]);
    int height = CGImageGetHeight([image CGImage]);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, CGImageGetWidth(cgImage)*4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, CGBitmapContextGetWidth(bitmapContext), CGBitmapContextGetHeight(bitmapContext)), cgImage);
    
    UInt8 *data = (UInt8 *)CGBitmapContextGetData(bitmapContext);

    int numComponents = 4;
    int bytesInContext = CGBitmapContextGetHeight(bitmapContext) * CGBitmapContextGetBytesPerRow(bitmapContext);
    
    int * array = (int*)malloc(level*sizeof(int));
    
    memset(array, 0, level*sizeof(int));
    
    for (int i=0; i < bytesInContext; i+= numComponents)
    {
        int pixelLevel = level*((0.3*data[i]+0.59*data[i+1]+0.11*data[i+2])/255.0);
        
        array[pixelLevel]++;
    }
    
    CGContextRelease(bitmapContext);
    
    NSMutableArray * resultArray = [NSMutableArray array];
    
    //find max count
    int maxCount = -1;
    for(int i = 0; i < level; i++)
    {
        if(array[i] > maxCount)
        {
            maxCount = array[i];
        }
    }
    
    for(int i = 0; i < level; i++)
    {
        if(array[i])
        {
            float levelValue = i/(float)level;
            float levelPresent = array[i]/(float)maxCount;
            
            [resultArray addObject:[NSMutableArray arrayWithObjects:
                                    [NSNumber numberWithFloat:levelValue],
                                    [NSNumber numberWithFloat:levelPresent],nil]];
            
            NSLog(@"[%d]=%f",i,levelPresent);
        }
    }
    
   

    free(array);
    
    return resultArray;
/*
    CGDataProviderRef
    provider = CGDataProviderCreateWithData(NULL,
                                            data,
                                            4*width*height,
                                            NULL
                                            );
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    //CGColorSpaceRef colorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGImageRef imageref2 = CGImageCreate(width,
                                         height,
                                         8,
                                         32,
                                         4 * width,
                                         colorspace,
                                         //注意这里要和取数据时一致
                                         kCGImageAlphaPremultipliedLast,
                                         provider,
                                         NULL,
                                         FALSE,
                                         kCGRenderingIntentDefault
                                         );

    UIImage * drawimage2 = [UIImage imageWithCGImage:imageref2];
    
    UIImageWriteToSavedPhotosAlbum(drawimage2, nil, nil, nil);
*/
   // CFRelease(provider);
  //  CGColorSpaceRelease(colorspace);
    
  
    
    
    return nil;
}

typedef struct
{
    float r,g,b;
    
}ETColor;




+ (ETColor)colorAtX:(int)x
                  y:(int)y
              width:(int)width
             height:(int)height
               data:(UInt8*)data
{
    ETColor color;
    
    if(x >= width || x < 0 || y >= height || y < 0)
    {
        color.r = 0;
        color.g = 0;
        color.b = 0;
        
        return color;
    }
    
    int index = width*4*y + x*4;
    color.r = data[index]/255.0;
    color.g = data[index+1]/255.0;
    color.b = data[index+2]/255.0;
    
    return color;
}

+ (ETColor)colorAtX:(int)x
                  y:(int)y
              width:(int)width
             height:(int)height
          baseColor:(ETColor)baseColor
               data:(UInt8*)data
{
    if(x < 0 || x >= width || y < 0 || y >= height)
    {
        return baseColor;
    }
  
    return [ETColorTool colorAtX:x
                               y:y
                           width:width
                          height:height
                            data:data];
}

+ (ETColor)colorSubtract:(ETColor)base color:(ETColor)color
{
    base.r -= color.r;
    base.g -= color.g;
    base.b -= color.b;
    return base;
}

+ (ETColor)colorAdd:(ETColor)colora color:(ETColor)colorb
{
    colora.r += colorb.r;
    colora.b += colorb.b;
    colora.g += colorb.g;
    
    return colora;
}

+ (ETColor)colorMul:(ETColor)colora scale:(float)scale
{
    colora.r *= scale;
    colora.b *= scale;
    colora.g *= scale;
    
    return colora;
}

+ (void)setColor:(ETColor)color toData:(UInt8*)data atX:(int)x y:(int)y width:(int)width height:(int)height
{
    if(color.r < 0)
    {
        color.r = 0;
    }else if(color.r > 1)
    {
        color.r = 1;
    }
    
    if(color.g < 0)
    {
        color.g = 0;
    }else if(color.g > 1)
    {
        color.g = 1;
    }
    
    if(color.b < 0)
    {
        color.b = 0;
    }else if(color.b > 1)
    {
        color.b =1;
    }
    
    int index = width*4*y+4*x;
    
    
    data[index] = color.r*255;
    data[index+1] = color.g*255;
    data[index+2] = color.b*255;
    data[index+3] = 255;
}

+ (UIImage *)imageSharpen:(UIImage*)image
{
    
    
    CGImageRef cgImage = [image CGImage];
    
    int width = CGImageGetWidth([image CGImage]);
    int height = CGImageGetHeight([image CGImage]);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, CGImageGetWidth(cgImage)*4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, CGBitmapContextGetWidth(bitmapContext), CGBitmapContextGetHeight(bitmapContext)), cgImage);
    
    UInt8 *data = (UInt8 *)CGBitmapContextGetData(bitmapContext);
    
    int bytesInContext = CGBitmapContextGetHeight(bitmapContext) * CGBitmapContextGetBytesPerRow(bitmapContext);
    
    UInt8 *targetData = (UInt8*)malloc(sizeof(UInt8)*bytesInContext);
    
    for (int i=0; i < width; i++)
    {
        for(int j = 0; j < height; j++)
        {
            ETColor color = [ETColorTool colorAtX:i
                                         y:j
                                     width:width
                                    height:height
                                      data:data];

            ETColor sumColor;
            sumColor.r = 0;
            sumColor.g = 0;
            sumColor.b = 0;
            
            sumColor = [ETColorTool colorAdd:sumColor
                                         color:[ETColorTool colorAtX:i-1
                                                                   y:j
                                                               width:width
                                                              height:height
                                                           baseColor:color
                                                                data:data]];
            
            sumColor = [ETColorTool colorAdd:sumColor
                                         color:[ETColorTool colorAtX:i+1
                                                                   y:j
                                                               width:width
                                                              height:height
                                                           baseColor:color
                                                                data:data]];
            
            /*  sumColor = [ETColorTool colorAdd:sumColor
                                         color:[ETColorTool colorAtX:i
                                                                   y:j+1
                                                               width:width
                                                              height:height
                                                           baseColor:color
                                                                data:data]];
            
            sumColor = [ETColorTool colorAdd:sumColor
                                         color:[ETColorTool colorAtX:i
                                                                   y:j-1
                                                               width:width
                                                              height:height
                                                           baseColor:color
                                                                data:data]];
            
          sumColor = [ETColorTool colorAdd:sumColor
                                       color:[ETColorTool colorAtX:i-1
                                                                 y:j-1
                                                             width:width
                                                            height:height
                                                         baseColor:color
                                                              data:data]];
            
            sumColor = [ETColorTool colorAdd:sumColor
                                       color:[ETColorTool colorAtX:i+1
                                                                 y:j-1
                                                             width:width
                                                            height:height
                                                         baseColor:color
                                                              data:data]];
            
            sumColor = [ETColorTool colorAdd:sumColor
                                       color:[ETColorTool colorAtX:i-1
                                                                 y:j+1
                                                             width:width
                                                            height:height
                                                         baseColor:color
                                                              data:data]];
            
            sumColor = [ETColorTool colorAdd:sumColor
                                       color:[ETColorTool colorAtX:i+1
                                                                 y:j+1
                                                             width:width
                                                            height:height
                                                         baseColor:color
                                                              data:data]];
            */
           /* sumColor.r /= 8.0;
            sumColor.g /= 8.0;
            sumColor.b /= 8.0;
            
            ETColor newColor = [self colorSubtract:color
                                             color:sumColor];
            */
            
            color = [self colorMul:color scale:3.0];
            
          /*  newColor = [self colorMul:newColor
                                scale:1.0];
            
            color = [self colorAdd:color
                             color:newColor];*/
            
            color = [self colorSubtract:color color:sumColor];
            
            [ETColorTool setColor:color
                           toData:targetData
                              atX:i
                                y:j
                            width:width
                           height:height];
        }
    
    }
    
    CGContextRelease(bitmapContext);
   
    
     CGDataProviderRef
     provider = CGDataProviderCreateWithData(NULL,
     targetData,
     4*width*height,
     NULL
     );
     CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
     //CGColorSpaceRef colorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
     CGImageRef imageref2 = CGImageCreate(width,
     height,
     8,
     32,
     4 * width,
     colorspace,
     //注意这里要和取数据时一致
     kCGImageAlphaPremultipliedLast,
     provider,
     NULL,
     FALSE,
     kCGRenderingIntentDefault
     );
     
     UIImage * drawimage2 = [UIImage imageWithCGImage:imageref2];
    
    UIImage * resultImage = nil;
    UIGraphicsBeginImageContext(drawimage2.size);
    [drawimage2 drawAtPoint:CGPointZero];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        
     CFRelease(provider);
     CGColorSpaceRelease(colorspace);
    
    free(targetData);
        
    return resultImage;

}

+ (UIImage*)imageAutoAdjustment:(UIImage *)originImage
{
        
    CIImage * image = [CIImage imageWithCGImage:originImage.CGImage];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:NO],
                           kCIImageAutoAdjustRedEye,
                           nil];
    
    NSArray * filters = [image autoAdjustmentFiltersWithOptions:dict];
    
    for(CIFilter * filter in filters)
    {
        [filter setValue:image forKey:kCIInputImageKey];
        
        image = [filter outputImage];
    }
    
    UIImage * targetImage = [UIImage imageWithCIImage:image];
    
    UIGraphicsBeginImageContext(targetImage.size);
    
    [targetImage drawAtPoint:CGPointZero];
    
    targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return [ETColorTool imageSharpen:targetImage];
}


+ (ETColor)colorAtIndexX:(int)x
                        Y:(int)y
                    width:(int)width
                   height:(int)height
                    data:(UInt8*)data
                    scale:(float)scale
                sumColor:(ETColor)sumColor
{
    ETColor color = [ETColorTool colorAtX:x
                                        y:y
                                    width:width
                                   height:height
                                     data:data];
    
    color = [ETColorTool colorMul:color
                         scale:scale];
    
    color  = [ETColorTool colorAdd:sumColor
                               color:color];
    
    return color;
}

+ (UIImage *)imageGauss:(UIImage*)image
{
    
    CGImageRef cgImage = [image CGImage];
    
    int width = CGImageGetWidth([image CGImage]);
    int height = CGImageGetHeight([image CGImage]);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, CGImageGetWidth(cgImage)*4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, CGBitmapContextGetWidth(bitmapContext), CGBitmapContextGetHeight(bitmapContext)), cgImage);
    
    UInt8 *data = (UInt8 *)CGBitmapContextGetData(bitmapContext);
    
    int bytesInContext = CGBitmapContextGetHeight(bitmapContext) * CGBitmapContextGetBytesPerRow(bitmapContext);
    
    UInt8 *targetData = (UInt8*)malloc(sizeof(UInt8)*bytesInContext);
    
    for (int i=0; i < width; i++)
    {
        for(int j = 0; j < height; j++)
        {
            
            ETColor sumColor;
            sumColor.r = 0;
            sumColor.g = 0;
            sumColor.b = 0;
            
           
            sumColor = [ETColorTool colorAtIndexX:i
                                                Y:j
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.147761
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i-1
                                                Y:j-1
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.094
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i
                                                Y:j-1
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.118
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i+1
                                                Y:j+1
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.094
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i-1
                                                Y:j
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.118
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i+1
                                                Y:j
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.118
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i
                                                Y:j+1
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.118
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i-1
                                                Y:j+1
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.094
                                         sumColor:sumColor];
            
            sumColor = [ETColorTool colorAtIndexX:i+1
                                                Y:j+1
                                            width:width
                                           height:height
                                             data:data
                                            scale:0.094
                                         sumColor:sumColor];

            
            
            [ETColorTool setColor:sumColor
                           toData:targetData
                              atX:i
                                y:j
                            width:width
                           height:height];
        }
        
    }
    
    CGContextRelease(bitmapContext);
    
    
    CGDataProviderRef
    provider = CGDataProviderCreateWithData(NULL,
                                            targetData,
                                            4*width*height,
                                            NULL
                                            );
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    //CGColorSpaceRef colorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGImageRef imageref2 = CGImageCreate(width,
                                         height,
                                         8,
                                         32,
                                         4 * width,
                                         colorspace,
                                         //注意这里要和取数据时一致
                                         kCGImageAlphaPremultipliedLast,
                                         provider,
                                         NULL,
                                         FALSE,
                                         kCGRenderingIntentDefault
                                         );
    
    UIImage * drawimage2 = [UIImage imageWithCGImage:imageref2];
    
    UIImage * resultImage = nil;
    UIGraphicsBeginImageContext(drawimage2.size);
    [drawimage2 drawAtPoint:CGPointZero];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CFRelease(provider);
    CGColorSpaceRelease(colorspace);
    
    free(targetData);
    
    return resultImage;   
    
}
@end
