//
//  Photo.m
//  InstaKilo
//
//  Created by Anton Moiseev on 2016-05-18.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)init {
    
    return [self initWithImage:nil type:nil];
    
}

- (instancetype)initWithImage:(UIImage *)image type:(NSString *)type {
    
    self = [super init];
    
    if (self) {
        
        _image = image;
        _type = type;
        
    }
    return self;
}

@end
