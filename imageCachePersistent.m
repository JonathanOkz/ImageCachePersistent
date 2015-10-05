//
//  imageCachePersistent.m
//  ImageCachePersistent
//
//  Created by Jonathan Oleszkiewicz on 03/09/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import "imageCachePersistent.h"


@implementation ImageCachePersistent


- (ImageCachePersistent *)initWithDirectory:(NSString *)directory {
    self = [super init];
    
	NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *mainBundle = [[NSBundle mainBundle] bundleIdentifier];
    NSString *rootPathDirectory = [cachesDirectory stringByAppendingPathComponent:mainBundle];
    NSString *pathDirectory = [rootPathDirectory stringByAppendingPathComponent:directory];
    NSLog(@"Init Cache -> cachesDirectory: %@", pathDirectory);

    _queue = dispatch_queue_create("com.JonathanOlesz.ImageCachePersistent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_set_target_queue(_queue, priority);
    
    _directory = pathDirectory;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:_directory]) {
        NSLog(@"Create directory");
        [[NSFileManager defaultManager] createDirectoryAtPath:_directory withIntermediateDirectories:YES attributes:nil error:NULL];
     }

	return self;
}

- (NSArray*)listImagesStored {
    
    NSArray *listImages = nil;
    
    @try {
        listImages = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_directory error:nil];
    } @catch (NSException* e) {
        NSLog(@"%@", e);
    }

	return listImages;
}

- (BOOL)imageExistForKey:(NSString *)key {
    
    BOOL boolean = FALSE;
    
    @try {
        NSString* path = [_directory stringByAppendingPathComponent:key];
        boolean = [[NSFileManager defaultManager] fileExistsAtPath:path];
    } @catch (NSException* e) {
        NSLog(@"%@", e);
    }
    
    return boolean;
}

- (UIImage *)getImageForKey:(NSString *)key {
	UIImage* image = nil;
	
	@try {
        NSString* path = [_directory stringByAppendingPathComponent:key];
		image = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	} @catch (NSException* e) {
        NSLog(@"%@", e);
	}
	
	return image;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key cb:(void (^)(BOOL boolean))cb {
    
    @try {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:image];
        NSString* path = [_directory stringByAppendingPathComponent:key];
        
        dispatch_async(_queue, ^{
            BOOL boolean = [data writeToFile:path atomically:YES];
            cb(boolean);
        });
        
    } @catch (NSException* e) {
        NSLog(@"%@", e);
    }
}

- (void)deleteImageForKey:(NSString *)key cb:(void (^)(BOOL boolean))cb {
    
    NSString* path = [_directory stringByAppendingPathComponent:key];
    
    dispatch_async(_queue, ^{
        BOOL boolean = [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
        cb(boolean);
    });
}

@end
