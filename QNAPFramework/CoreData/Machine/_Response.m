// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Response.m instead.

#import "_Response.h"

const struct ResponseAttributes ResponseAttributes = {
	.code = @"code",
	.message = @"message",
};

const struct ResponseRelationships ResponseRelationships = {
};

const struct ResponseFetchedProperties ResponseFetchedProperties = {
};

@implementation ResponseID
@end

@implementation _Response

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Response" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Response";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Response" inManagedObjectContext:moc_];
}

- (ResponseID*)objectID {
	return (ResponseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"codeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"code"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic code;



- (int32_t)codeValue {
	NSNumber *result = [self code];
	return [result intValue];
}

- (void)setCodeValue:(int32_t)value_ {
	[self setCode:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCodeValue {
	NSNumber *result = [self primitiveCode];
	return [result intValue];
}

- (void)setPrimitiveCodeValue:(int32_t)value_ {
	[self setPrimitiveCode:[NSNumber numberWithInt:value_]];
}





@dynamic message;











@end
