// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.birthday = @"birthday",
	.email = @"email",
	.first_name = @"first_name",
	.gender = @"gender",
	.language = @"language",
	.last_name = @"last_name",
	.mobile_number = @"mobile_number",
	.subscribed = @"subscribed",
};

const struct UserRelationships UserRelationships = {
};

const struct UserFetchedProperties UserFetchedProperties = {
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"genderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gender"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"subscribedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"subscribed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic birthday;






@dynamic email;






@dynamic first_name;






@dynamic gender;



- (int32_t)genderValue {
	NSNumber *result = [self gender];
	return [result intValue];
}

- (void)setGenderValue:(int32_t)value_ {
	[self setGender:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveGenderValue {
	NSNumber *result = [self primitiveGender];
	return [result intValue];
}

- (void)setPrimitiveGenderValue:(int32_t)value_ {
	[self setPrimitiveGender:[NSNumber numberWithInt:value_]];
}





@dynamic language;






@dynamic last_name;






@dynamic mobile_number;






@dynamic subscribed;



- (BOOL)subscribedValue {
	NSNumber *result = [self subscribed];
	return [result boolValue];
}

- (void)setSubscribedValue:(BOOL)value_ {
	[self setSubscribed:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSubscribedValue {
	NSNumber *result = [self primitiveSubscribed];
	return [result boolValue];
}

- (void)setPrimitiveSubscribedValue:(BOOL)value_ {
	[self setPrimitiveSubscribed:[NSNumber numberWithBool:value_]];
}










@end
