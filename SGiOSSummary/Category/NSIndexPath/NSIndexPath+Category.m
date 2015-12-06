//
//  NSIndexPath+Category.m
//  Toing
//
//  Created by Rdd7 on 7/5/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import "NSIndexPath+Category.h"

@implementation NSIndexPath(Category)

-(BOOL)isequalToIndexPath:(NSIndexPath *)indexPath{
    return (self.row==indexPath.row&&self.section==indexPath.section)?YES:NO;
}

@end
