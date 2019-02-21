//
//  NSDictionary+InaTypedValue.h
//  NJII
//
//  Created by Mihail Varbanov on 2/12/19.
//  Copyright © 2019 Inabyte Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(InaTypedValue)

	- (int)inaIntForKey:(id)key;
	- (int)inaIntForKey:(id)key defaults:(int)defaultValue;

	- (long)inaLongForKey:(id)key;
	- (long)inaLongForKey:(id)key defaults:(long)defaultValue;

	- (NSInteger)inaIntegerForKey:(id)key;
	- (NSInteger)inaIntegerForKey:(id)key defaults:(NSInteger)defaultValue;

	- (int64_t)inaInt64ForKey:(id)key;
	- (int64_t)inaInt64ForKey:(id)key defaults:(int64_t)defaultValue;

	- (bool)inaBoolForKey:(id)key;
	- (bool)inaBoolForKey:(id)key defaults:(bool)defaultValue;
	
	- (float)inaFloatForKey:(id)key;
	- (float)inaFloatForKey:(id)key defaults:(float)defaultValue;
	
	- (double)inaDoubleForKey:(id)key;
	- (double)inaDoubleForKey:(id)key defaults:(double)defaultValue;
	
	- (NSString*)inaStringForKey:(id)key;
	- (NSString*)inaStringForKey:(id)key defaults:(NSString*)defaultValue;

	- (NSNumber*)inaNumberForKey:(id)key;
	- (NSNumber*)inaNumberForKey:(id)key defaults:(NSNumber*)defaultValue;

	- (NSDictionary*)inaDictForKey:(id)key;
	- (NSDictionary*)inaDictForKey:(id)key defaults:(NSDictionary*)defaultValue;

	- (NSArray*)inaArrayForKey:(id)key;
	- (NSArray*)inaArrayForKey:(id)key defaults:(NSArray*)defaultValue;

	- (NSValue*)inaValueForKey:(id)key;
	- (NSValue*)inaValueForKey:(id)key defaults:(NSValue*)defaultValue;

	- (NSData*)inaDataForKey:(id)key;
	- (NSData*)inaDataForKey:(id)key defaults:(NSData*)defaultValue;

	- (SEL)inaSelectorForKey:(id)key;
	- (SEL)inaSelectorForKey:(id)key defaults:(SEL)defaultValue;
@end
