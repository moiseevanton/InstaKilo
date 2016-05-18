//
//  Photo.h
//  InstaKilo
//
//  Created by Anton Moiseev on 2016-05-18.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *type;

- (instancetype)initWithImage:(UIImage *)image type:(NSString *)type;

@end
