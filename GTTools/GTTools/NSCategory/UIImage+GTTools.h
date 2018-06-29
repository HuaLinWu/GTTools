//
//  UIImage+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GTCompressImage)

/**
 压缩图片到指定的字节大小

 @param kb 指定的字节大小
 @return 返回jpg 格式的二进制
 */
- (NSData *)gt_compressImageToKb:(NSInteger)kb;

@end
@interface UIImage(GTTransform)
/*
 *  使图片垂直
 */
- (UIImage *)gt_fixOrientation;
@end
@interface UIImage (GTTailor)

/**
 将图片裁剪成圆形(最大的内切圆)

 @return 裁切过后的图片
 */
- (UIImage*)gt_maxInscribedCircleImage;

/**
 将图片裁剪成圆形（圆心为图片的中心）

 @param radius 圆的半径
 @param borderWidth 图片的边宽
 @param borderColor 外边框的颜色
 @return 裁剪过后的图片
 */
- (UIImage *)gt_circleImageWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
@interface UIImage (GTCreate)

/**
 根据颜色创建纯色图片

 @param color 颜色
 @param size 图片大小
 @return 生成的图片
 */
+ (UIImage *)gt_createImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据文字创建和文字合适的大小的图片

 @param attributedString 富文本
 @param size 限制的大小
 @return 返回图片
 */
+ (UIImage *)gt_createImageWithAttributedString:(NSAttributedString *)attributedString limitingSize:(CGSize)size;

/**
 利用富文本给图片打上log

 @param attributedString 富文本
 @param logFrame 富文本所在的坐标
 @return 返回打上log图片
 */
- (UIImage *)gt_createImageWithLogAttributedString:(NSAttributedString *)attributedString logFrame:(CGRect)logFrame;

/**
  利用图片给图片打上log

 @param logImage log图片
 @param logFrame log图片的坐标
 @return 返回打上log图片
 */
- (UIImage *)gt_createImageWithLogImage:(UIImage *)logImage logFrame:(CGRect)logFrame;
@end
@interface UIImage (GTEncrypt)

/**
 将base64加密过后的转化成UIImage

 @param base64Data base64 数据
 @return UIImage
 */
+ (UIImage *)gt_imageFromBase64Data:(NSData *)base64Data;

/**
 将图片base64 加密

 @return 加密过后的数据
 */
- (NSData *)gt_base64Data;

/**
 先将图压缩到指定的大小，然后进行加密

 @param kb 需要压缩到的大小
 @return 返回base64位加密过后的NSData
 */
- (NSData *)gt_base64DataAndCompressToKb:(NSInteger)kb;
@end
