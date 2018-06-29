//
//  UIImage+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIImage+GTTools.h"
#import "NSAttributedString+GTTools.h"
#import "NSData+GTTools.h"
@implementation UIImage (GTScaleImage)
-(NSData *)gt_compressImageToKb:(NSInteger)kb {
    NSData *imageData = nil;
    imageData =  UIImageJPEGRepresentation(self, 1);
    if(imageData.length/1024.0 <=kb) {
        return imageData;
    } else {
        CGFloat compressionQuality = kb *1024/imageData.length;
        imageData =  UIImageJPEGRepresentation(self, compressionQuality);
        return imageData;
    }
}
@end
@implementation UIImage(GTTransform)
- (UIImage *)gt_fixOrientation {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
@implementation UIImage (GTTailor)
- (UIImage*)gt_maxInscribedCircleImage {
    
   CGFloat radius = MIN(self.size.width, self.size.height)/2;
    return [self gt_circleImageWithRadius:radius borderWidth:0 borderColor:nil];;
}
- (UIImage *)gt_circleImageWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(self.size.width/2, self.size.height/2);
    if(borderWidth>0) {
        CGContextSetLineWidth(context, borderWidth);
    }
    if(borderColor) {
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    }
    CGContextAddArc(context, center.x, center.y, radius, 0, M_PI*2, 0);
    CGContextClip(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
@implementation UIImage (GTCreate)
+ (UIImage *)gt_createImageWithColor:(UIColor *)color size:(CGSize)size {
    if(!color || CGSizeEqualToSize(CGSizeZero, size)) {
        return nil;
    } else {
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
+ (UIImage *)gt_createImageWithAttributedString:(NSAttributedString *)attributedString limitingSize:(CGSize)size {
    if(!attributedString || CGSizeEqualToSize(CGSizeZero, size)) {
        return nil;
    } else {
        CGRect rect = [attributedString gt_boundingRectWithSize:size];
        UIGraphicsBeginImageContext(rect.size);
        [attributedString drawInRect:rect];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
- (UIImage *)gt_createImageWithLogAttributedString:(NSAttributedString *)attributedString logFrame:(CGRect)logFrame {
    if(!attributedString || CGRectIsEmpty(logFrame)) {
        return self;
    } else {
        UIGraphicsBeginImageContext(logFrame.size);
        [attributedString drawInRect:logFrame];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
- (UIImage *)gt_createImageWithLogImage:(UIImage *)logImage logFrame:(CGRect)logFrame {
    if(!logImage || CGRectIsEmpty(logFrame)) {
        return self;
    } else {
        UIGraphicsBeginImageContext(logFrame.size);
        [logImage drawInRect:logFrame];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}
@end
@implementation UIImage (GTEncrypt)
+ (UIImage *)gt_imageFromBase64Data:(NSData *)base64Data {
    if(!base64Data) {
        return nil;
    } else {
        UIImage *image = [UIImage imageWithData:[base64Data base64Decode]] ;
        return image;
    }
}
- (NSData *)gt_base64Data {
   NSData *base64Data = UIImagePNGRepresentation(self);
    return [base64Data base64Encode];
}
- (NSData *)gt_base64DataAndCompressToKb:(NSInteger)kb {
    NSData*data = [self gt_compressImageToKb:kb];
    return [data base64Encode];
}
@end
