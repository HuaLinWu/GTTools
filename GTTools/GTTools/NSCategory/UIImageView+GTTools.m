//
//  UIImageView+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIImageView+GTTools.h"

@implementation UIImageView (GTTools)
- (void)gt_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)image {
    if(image) {
        self.image = image;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    
}
@end
