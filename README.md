### QNAPFramework.
You can use QNAPFramework to build an iOS app quickly which has some functions with your QNAP NAS machines. This framework contains FileManagerAPI, MusicStation API, PhotoStation API, myCloud API and so on. You can just invoke these methods and don't deal with any detail of HTTP request, asynchronism problems, parsing and others. Facing to various HTTP behaviors from many different development teams, this framework is an elegant and carefully designed set of APIs which including RESTful, common Webservice, http response in XML format, http response in JSON format, http header control, credential information and a lot of details. For login example, you only simply invoke a method such as:

```Objective-C
//create a fileStationManager
self.fileStationManager = [[QNAPCommunicationManager share] factoryForFileStatioAPIManager:NASURL];
//login method
[self.fileStationManager loginWithAccount:NAS_ACCOUNT
                             withPassword:NAS_PASSWORD
                         withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult, QNFileLogin *login){
                             [self.loginLabel setText:@"登入成功"];
                         }
                         withFailureBlock:^(RKObjectRequestOperation *operation, QNFileLoginError *error){
                             [self.loginLabel setText:@"登入失敗"];
                         }];
```
An easy way to login!

QNAPFramework is integrated several powerful libraries to complete its works:
* Based on [RESTKit](https://github.com/RestKit/RestKit) which is a powerful object mapping engine that seamlessly integrates with Core Data and a simple set of networking primitives for mapping HTTP requests and responses built on top of [AFNetworking](https://github.com/AFNetworking/AFNetworking).
* Integrated with [MagicalRecord](https://github.com/magicalpanda/MagicalRecord) by sharing same NSManagedObjectContext and NSPersistentStoreCoordinator, which may save you a lot of effort in dealing with CoreData.
* Integrated with [SDWebImage](https://github.com/rs/SDWebImage) which giving you a lazy loading of pictures and managing the picture cache easily.

### How to install
