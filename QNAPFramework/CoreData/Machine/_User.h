// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>


extern const struct UserAttributes {
	__unsafe_unretained NSString *birthday;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *first_name;
	__unsafe_unretained NSString *gender;
	__unsafe_unretained NSString *language;
	__unsafe_unretained NSString *last_name;
	__unsafe_unretained NSString *mobile_number;
	__unsafe_unretained NSString *subscribed;
} UserAttributes;

extern const struct UserRelationships {
} UserRelationships;

extern const struct UserFetchedProperties {
} UserFetchedProperties;











@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserID*)objectID;





@property (nonatomic, strong) NSString* birthday;



//- (BOOL)validateBirthday:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* first_name;



//- (BOOL)validateFirst_name:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* gender;



@property int32_t genderValue;
- (int32_t)genderValue;
- (void)setGenderValue:(int32_t)value_;

//- (BOOL)validateGender:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* language;



//- (BOOL)validateLanguage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* last_name;



//- (BOOL)validateLast_name:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mobile_number;



//- (BOOL)validateMobile_number:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* subscribed;



@property BOOL subscribedValue;
- (BOOL)subscribedValue;
- (void)setSubscribedValue:(BOOL)value_;

//- (BOOL)validateSubscribed:(id*)value_ error:(NSError**)error_;






@end

@interface _User (CoreDataGeneratedAccessors)

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBirthday;
- (void)setPrimitiveBirthday:(NSString*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFirst_name;
- (void)setPrimitiveFirst_name:(NSString*)value;




- (NSNumber*)primitiveGender;
- (void)setPrimitiveGender:(NSNumber*)value;

- (int32_t)primitiveGenderValue;
- (void)setPrimitiveGenderValue:(int32_t)value_;




- (NSString*)primitiveLanguage;
- (void)setPrimitiveLanguage:(NSString*)value;




- (NSString*)primitiveLast_name;
- (void)setPrimitiveLast_name:(NSString*)value;




- (NSString*)primitiveMobile_number;
- (void)setPrimitiveMobile_number:(NSString*)value;




- (NSNumber*)primitiveSubscribed;
- (void)setPrimitiveSubscribed:(NSNumber*)value;

- (BOOL)primitiveSubscribedValue;
- (void)setPrimitiveSubscribedValue:(BOOL)value_;




@end
