//
//  imageCacheTemporary.m
//  ImageCachePersistent
//
//  Created by Jonathan Oleszkiewicz on 03/09/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import "imageCacheTemporary.h"

@implementation ImageCacheTemporary


- (ImageCacheTemporary *)initWithDirectory:(NSString *)directory {
    self = [super init];
    
    self.evictsObjectsWithDiscardedContent = YES;
    self.totalCostLimit = 0;
    self.countLimit = 0;
    _directory = directory;
    
    return self;
}

- (UIImage *)getImageForKey:(NSString *)key {
    NSString* path = [_directory stringByAppendingPathComponent:key];
    UIImage *image = [self objectForKey:path];
    
    return image;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    NSString* path = [_directory stringByAppendingPathComponent:key];
    [self setObject:image forKey:path];
}

- (void)deleteImageForKey:(NSString *)key {
    NSString* path = [_directory stringByAppendingPathComponent:key];
    [self removeObjectForKey:path];
}

- (void)deleteAllImage {
    [self removeAllObjects];
}

@end
