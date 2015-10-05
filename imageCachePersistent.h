//
//  imageCachePersistent.h
//  ImageCachePersistent
//
//  Created by Jonathan Oleszkiewicz on 03/09/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCachePersistent : NSObject {
    @private
    dispatch_queue_t    _queue;
    NSString            *_directory;
}


- (nullable ImageCachePersistent *)initWithDirectory:(nonnull NSString *)directory;

- (nullable NSArray*)listImagesStored;

- (BOOL)imageExistForKey:(nonnull NSString *)key;

- (nullable UIImage *)getImageForKey:(nonnull NSString *)key;

- (void)setImage:(nonnull UIImage *)image forKey:(nonnull NSString *)key cb:(nullable void(^)(BOOL boolean))cb;

- (void)deleteImageForKey:(nonnull NSString *)key cb:(nullable void (^)(BOOL boolean))cb;


@end