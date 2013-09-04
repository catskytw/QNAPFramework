// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Response.h instead.

#import <CoreData/CoreData.h>


extern const struct ResponseAttributes {
	__unsafe_unretained NSString *code;
	__unsafe_unretained NSString *message;
} ResponseAttributes;

extern const struct ResponseRelationships {
} ResponseRelationships;

extern const struct ResponseFetchedProperties {
} ResponseFetchedProperties;





@interface ResponseID : NSManagedObjectID {}
@end

@interface _Response : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ResponseID*)objectID;





@property (nonatomic, strong) NSNumber* code;



@property int32_t codeValue;
- (int32_t)codeValue;
- (void)setCodeValue:(int32_t)value_;

//- (BOOL)validateCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* message;



//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;






@end

@interface _Response (CoreDataGeneratedAccessors)

@end

@interface _Response (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCode;
- (void)setPrimitiveCode:(NSNumber*)value;

- (int32_t)primitiveCodeValue;
- (void)setPrimitiveCodeValue:(int32_t)value_;




- (NSString*)primitiveMessage;
- (void)setPrimitiveMessage:(NSString*)value;




@end
