//
//  GTFileManager.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/1.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GTFileManager : NSObject

/**
 创建文件（如果父级目录不存在，会创建父级目录,如果文件原本就存在会先删除再创建）

 @param filePath 文件路径
 @return 是否创建成功（YES 表示创建成功，NO表示创建失败）
 */
+ (BOOL)createEmptyFileInPath:(NSString *)filePath;

/**
 

 @param filePath 文件路径
 @return 如果删除成功返回YES，NO表示删除失败
 */
+ (BOOL)deleteFileInPath:(NSString *)filePath;

/**
 创建Directory在指定的path（如果对应的上级目录不存在，会创建上级目录,如果以前就存在对应的文件目录不会清除目录下的文件）

 @param directoryPath 问价夹目录
 @return 是否创建成功（YES 表示创建成功，NO表示创建失败）
 */
+ (BOOL)createDirectoryInPath:(NSString *)directoryPath;

/**
 文件是否存在

 @param filePath 指定的文件路径
 @return 如果文件存在返回YES，否则返回NO
 */
+ (BOOL)fileExistsAtPath:(NSString *)filePath;
/**
 document 文件夹的路径
 */
+ (NSString *)documentDirectoryPath;

/**
 cache 文件夹的路径
 */
+ (NSString *)cacheDirectoryPath;

/**
 temp文件夹的路径
 */
+ (NSString *)tempDirectoryPath;

/**
 将数据写入到指定的文件中

 @param data 需要写入到文件中的数据
 @param path 文件路径
 @return 是否写入成功
 */
+ (BOOL)writeData:(NSData *)data toFile:(NSString *)path;
@end
