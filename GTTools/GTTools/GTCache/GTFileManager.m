//
//  GTFileManager.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/1.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTFileManager.h"
@implementation GTFileManager
+ (BOOL)createEmptyFileInPath:(NSString *)filePath {
    
    if(filePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:filePath]) {
           return [self deleteFileInPath:filePath];
        }
        //创建对应的文件
       NSURL *fileURL = [NSURL fileURLWithPath:filePath];
       NSString *lastPathComponent = fileURL.lastPathComponent;
       NSMutableArray *filePathComponents = [NSMutableArray arrayWithArray:fileURL.pathComponents];
       [filePathComponents removeObject:lastPathComponent];
       NSString *directoryPath = [filePathComponents componentsJoinedByString:@"/"];
        if([self createDirectoryInPath:directoryPath]) {
            return [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        } else {
            return NO;
        }
        
    }
    return NO;
}
+ (BOOL)deleteFileInPath:(NSString *)filePath {
    if(filePath) {
         NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:filePath]) {
            return [fileManager removeItemAtPath:filePath error:nil];
        } else {
            return YES;
        }
    }
    return YES;
}
+ (BOOL)createDirectoryInPath:(NSString *)directoryPath {
    
    if(directoryPath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
       return [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}
+ (BOOL)fileExistsAtPath:(NSString *)filePath  {
    if(filePath) {
       NSFileManager *fileManager = [NSFileManager defaultManager];
        return [fileManager fileExistsAtPath:filePath];
    }
    return NO;
}
+ (NSString *)documentDirectoryPath {
    NSArray *dires = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if(dires>0) {
        return dires[0];
    } else {
        return nil;
    }
}

+ (NSString *)cacheDirectoryPath {
    NSArray *dires = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if(dires>0) {
        return dires[0];
    } else {
        return nil;
    }
}

+ (NSString *)tempDirectoryPath {
   return  NSTemporaryDirectory();
}
+ (BOOL)writeData:(NSData *)data toFile:(NSString *)path {
    if(path && data) {
        [self createEmptyFileInPath:path];
       return  [data writeToFile:path atomically:YES];
    }
    return NO;
}
+ (NSData *)readDataFromFile:(NSString *)path {
    if([self fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        return data;
    } else {
        return nil;
    }
}
@end
