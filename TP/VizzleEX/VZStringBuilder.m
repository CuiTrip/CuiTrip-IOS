//
//  VZStringBuilder.m
//  TP
//
//  Created by moxin on 15/6/4.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZStringBuilder.h"
#import <CoreText/CTFont.h>
#import <CoreText/CTStringAttributes.h>



@implementation VZStringBuilder


+ (float) heightForString:(NSString *)myString  Font:(UIFont *)myFont Width:(float)myWidth
{
    NSMutableAttributedString* attributedText = [[NSMutableAttributedString alloc]initWithString:myString];
    [attributedText addAttribute:NSFontAttributeName value:myFont
                           range:NSMakeRange(0, [attributedText length])];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    CGRect boundingRect = [attributedText boundingRectWithSize:CGSizeMake(myWidth, CGFLOAT_MAX)
                                                       options:options
                                                       context:nil];
    return ceil(boundingRect.size.height);
}


@end


@implementation VZStringBuilder(CoreText)

+ (BOOL)isCoreTextAttribute:(NSString* )attribute
{
    static NSSet* coreTextSet;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        coreTextSet = [NSSet setWithObjects:(__bridge id)kCTForegroundColorAttributeName,
                       kCTForegroundColorFromContextAttributeName,
                       kCTForegroundColorAttributeName,
                       kCTStrokeColorAttributeName,
                       kCTUnderlineStyleAttributeName,
                       kCTVerticalFormsAttributeName,
                       kCTRunDelegateAttributeName,
                       kCTBaselineClassAttributeName,
                       kCTBaselineInfoAttributeName,
                       kCTBaselineReferenceInfoAttributeName,
                       kCTUnderlineColorAttributeName,
                       nil];
        
        
    });
    
    return [coreTextSet containsObject:attribute];
}

+ (NSDictionary* )transformCoreTextAttributes:(NSDictionary* )coreTextAttributes{
    
    NSMutableDictionary *cleanAttributes = [[NSMutableDictionary alloc] initWithCapacity:coreTextAttributes.count];
    
    [coreTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString *coreTextKey, id coreTextValue, BOOL *stop) {
        // The following attributes are not supported on NSAttributedString. Should they become available, we should add them.
        /*
         kCTForegroundColorFromContextAttributeName
         kCTSuperscriptAttributeName
         kCTGlyphInfoAttributeName
         kCTCharacterShapeAttributeName
         kCTLanguageAttributeName
         kCTRunDelegateAttributeName
         kCTBaselineClassAttributeName
         kCTBaselineInfoAttributeName
         kCTBaselineReferenceInfoAttributeName
         kCTWritingDirectionAttributeName
         kCTUnderlineColorAttributeName
         */
        
        // Conversely, the following attributes are not supported on CFAttributedString. Should they become available, we should add them.
        /*
         NSStrikethroughStyleAttributeName
         NSShadowAttributeName
         NSBackgroundColorAttributeName
         */
        
        // kCTFontAttributeName -> NSFontAttributeName
        if ([coreTextKey isEqualToString:(NSString *)kCTFontAttributeName]) {
            CTFontRef coreTextFont = (__bridge CTFontRef)coreTextValue;
            NSString *fontName = (__bridge_transfer NSString *)CTFontCopyPostScriptName(coreTextFont);
            CGFloat fontSize = CTFontGetSize(coreTextFont);
            
            cleanAttributes[NSFontAttributeName] = [UIFont fontWithName:fontName size:fontSize];
        }
        // kCTKernAttributeName -> NSKernAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTKernAttributeName]) {
            cleanAttributes[NSKernAttributeName] = (NSNumber *)coreTextValue;
        }
        // kCTLigatureAttributeName -> NSLigatureAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTLigatureAttributeName]) {
            cleanAttributes[NSLigatureAttributeName] = (NSNumber *)coreTextValue;
        }
        // kCTForegroundColorAttributeName -> NSForegroundColorAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTForegroundColorAttributeName]) {
            cleanAttributes[NSForegroundColorAttributeName] = [UIColor colorWithCGColor:(CGColorRef)coreTextValue];
        }
        // kCTParagraphStyleAttributeName -> NSParagraphStyleAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTParagraphStyleAttributeName]) {
            cleanAttributes[NSParagraphStyleAttributeName] = [self paragraphStyleWithCTParagraphStyle:(CTParagraphStyleRef)coreTextValue];
        }
        // kCTStrokeWidthAttributeName -> NSStrokeWidthAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTStrokeWidthAttributeName]) {
            cleanAttributes[NSStrokeWidthAttributeName] = (NSNumber *)coreTextValue;
        }
        // kCTStrokeColorAttributeName -> NSStrokeColorAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTStrokeColorAttributeName]) {
            cleanAttributes[NSStrokeColorAttributeName] = [UIColor colorWithCGColor:(CGColorRef)coreTextValue];
        }
        // kCTUnderlineStyleAttributeName -> NSUnderlineStyleAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTUnderlineStyleAttributeName]) {
            cleanAttributes[NSUnderlineStyleAttributeName] = (NSNumber *)coreTextValue;
        }
        // kCTVerticalFormsAttributeName -> NSVerticalGlyphFormAttributeName
        else if ([coreTextKey isEqualToString:(NSString *)kCTVerticalFormsAttributeName]) {
            BOOL flag = (BOOL)CFBooleanGetValue((CFBooleanRef)coreTextValue);
            cleanAttributes[NSVerticalGlyphFormAttributeName] = @((int)flag); // NSVerticalGlyphFormAttributeName is documented to be an NSNumber with an integer that's either 0 or 1.
        }
        // Don't filter out any internal text attributes
        else if (![self isCoreTextAttribute:coreTextKey]){
            cleanAttributes[coreTextKey] = coreTextValue;
        }
    }];
    
    return cleanAttributes;

    
}

+ (NSAttributedString* )cleanCoreTextAttributes:(NSAttributedString* )dirtyAttributedString
{
    if (!dirtyAttributedString)
        return nil;
    
    // First see if there are any core text attributes on the string
    __block BOOL containsCoreTextAttributes = NO;
    [dirtyAttributedString enumerateAttributesInRange:NSMakeRange(0, dirtyAttributedString.length)
                                              options:0
                                           usingBlock:^(NSDictionary *dirtyAttributes, NSRange range, BOOL *stop) {
                                               [dirtyAttributes enumerateKeysAndObjectsUsingBlock:^(NSString *coreTextKey, id coreTextValue, BOOL *innerStop) {
                                                   if ([self isCoreTextAttribute:coreTextKey]) {
                                                       containsCoreTextAttributes = YES;
                                                       *innerStop = YES;
                                                   }
                                               }];
                                               *stop = containsCoreTextAttributes;
                                           }];
    if (containsCoreTextAttributes) {
        
        NSString *plainString = dirtyAttributedString.string;
        NSMutableAttributedString *cleanAttributedString = [[NSMutableAttributedString alloc] initWithString:plainString];
        
        // Iterate over all of the attributes, cleaning them as appropriate and applying them as we go.
        [dirtyAttributedString enumerateAttributesInRange:NSMakeRange(0, plainString.length)
                                                  options:0
                                               usingBlock:^(NSDictionary *dirtyAttributes, NSRange range, BOOL *stop) {
                                                   [cleanAttributedString addAttributes:[self transformCoreTextAttributes:dirtyAttributes] range:range];
                                               }];
        
        return cleanAttributedString;
    } else {
        return dirtyAttributedString;
    }
}

+ (NSMutableParagraphStyle* )paragraphStyleWithCTParagraphStyle:(CTParagraphStyleRef)coreTextParagraphStyle;
{
    NSMutableParagraphStyle *newParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    if (!coreTextParagraphStyle)
        return newParagraphStyle;
    
    // The following paragraph style specifiers are not supported on NSParagraphStyle. Should they become available, we should add them.
    /*
     kCTParagraphStyleSpecifierTabStops
     kCTParagraphStyleSpecifierDefaultTabInterval
     kCTParagraphStyleSpecifierMaximumLineSpacing
     kCTParagraphStyleSpecifierMinimumLineSpacing
     kCTParagraphStyleSpecifierLineSpacingAdjustment
     kCTParagraphStyleSpecifierLineBoundsOptions
     */
    
    // Conversely, the following paragraph styles are not supported on CTParagraphStyle. Should they become available, we should add them.
    /*
     hyphenationFactor
     */
    
    // kCTParagraphStyleSpecifierAlignment -> alignment
    CTTextAlignment coreTextAlignment;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierAlignment, sizeof(coreTextAlignment), &coreTextAlignment))
        newParagraphStyle.alignment = NSTextAlignmentFromCTTextAlignment(coreTextAlignment);
    
    // kCTParagraphStyleSpecifierFirstLineHeadIndent -> firstLineHeadIndent
    CGFloat firstLineHeadIndent;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(firstLineHeadIndent), &firstLineHeadIndent))
        newParagraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    
    // kCTParagraphStyleSpecifierHeadIndent -> headIndent
    CGFloat headIndent;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierHeadIndent, sizeof(headIndent), &headIndent))
        newParagraphStyle.headIndent = headIndent;
    
    // kCTParagraphStyleSpecifierTailIndent -> tailIndent
    CGFloat tailIndent;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierTailIndent, sizeof(tailIndent), &tailIndent))
        newParagraphStyle.tailIndent = tailIndent;
    
    // kCTParagraphStyleSpecifierLineBreakMode -> lineBreakMode
    CTLineBreakMode coreTextLineBreakMode;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierLineBreakMode, sizeof(coreTextLineBreakMode), &coreTextLineBreakMode))
        newParagraphStyle.lineBreakMode = (NSLineBreakMode)coreTextLineBreakMode; // They're the same enum.
    
    // kCTParagraphStyleSpecifierLineHeightMultiple -> lineHeightMultiple
    CGFloat lineHeightMultiple;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierLineHeightMultiple, sizeof(lineHeightMultiple), &lineHeightMultiple))
        newParagraphStyle.lineHeightMultiple = lineHeightMultiple;
    
    // kCTParagraphStyleSpecifierMaximumLineHeight -> maximumLineHeight
    CGFloat maximumLineHeight;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(maximumLineHeight), &maximumLineHeight))
        newParagraphStyle.maximumLineHeight = maximumLineHeight;
    
    // kCTParagraphStyleSpecifierMinimumLineHeight -> minimumLineHeight
    CGFloat minimumLineHeight;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(minimumLineHeight), &minimumLineHeight))
        newParagraphStyle.minimumLineHeight = minimumLineHeight;
    
    // kCTParagraphStyleSpecifierLineSpacing -> lineSpacing
    // Note that kCTParagraphStyleSpecifierLineSpacing is deprecated and will die soon. We should not be using it.
    CGFloat lineSpacing;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierLineSpacing, sizeof(lineSpacing), &lineSpacing))
        newParagraphStyle.lineSpacing = lineSpacing;
    
    // kCTParagraphStyleSpecifierParagraphSpacing -> paragraphSpacing
    CGFloat paragraphSpacing;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierParagraphSpacing, sizeof(paragraphSpacing), &paragraphSpacing))
        newParagraphStyle.paragraphSpacing = paragraphSpacing;
    
    // kCTParagraphStyleSpecifierParagraphSpacingBefore -> paragraphSpacingBefore
    CGFloat paragraphSpacingBefore;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(paragraphSpacingBefore), &paragraphSpacingBefore))
        newParagraphStyle.paragraphSpacingBefore = paragraphSpacingBefore;
    
    // kCTParagraphStyleSpecifierBaseWritingDirection -> baseWritingDirection
    CTWritingDirection coreTextBaseWritingDirection;
    if (CTParagraphStyleGetValueForSpecifier(coreTextParagraphStyle, kCTParagraphStyleSpecifierBaseWritingDirection, sizeof(coreTextBaseWritingDirection), &coreTextBaseWritingDirection))
        newParagraphStyle.baseWritingDirection = (NSWritingDirection)coreTextBaseWritingDirection; // They're the same enum.
    
    return newParagraphStyle;
}


@end