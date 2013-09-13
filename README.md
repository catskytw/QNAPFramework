### QNAPFramework
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
Another downloading sample:
```objc
[self.fileManager downloadFileWithFilePath:YOUR_FILE_PATH
                              withFileName:YOUR_FILE_NAME
                                  isFolder:NO
                                 withRange:nil //give the range for resume downloading
                          withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                              DDLogVerbose(@"download success!");
                              //update your UI status
                          }
                          withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                              DDLogError(@"download error, Error: %@ !", error);
                              //give an alert to show error
                          }
                       withInProgressBlock:^(long long totalBytesRead, long long totalBytesExpectedToRead){
                           DDLogVerbose(@"download file progress %lldbytes/%lldbytes", totalBytesRead, totalBytesExpectedToRead);
                           //update progress bar
                       }];
```

QNAPFramework is integrated with several powerful libraries to complete its works:
* Based on [RESTKit](https://github.com/RestKit/RestKit) which is a powerful object mapping engine that seamlessly integrates with Core Data and a simple set of networking primitives for mapping HTTP requests and responses built on top of [AFNetworking](https://github.com/AFNetworking/AFNetworking).
* Integrated with [MagicalRecord](https://github.com/magicalpanda/MagicalRecord) by sharing same NSManagedObjectContext and NSPersistentStoreCoordinator, which may save you a lot of effort in dealing with CoreData.
* Integrated with [SDWebImage](https://github.com/rs/SDWebImage) which giving you a lazy loading of pictures and managing the picture cache easily.
* Others: [AFOAuth2Client](https://github.com/AFNetworking/AFOAuth2Client), [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack), [Expecta](https://github.com/specta/expecta)

### Installation
The only way to install QNAPFramework is via [Cocoapods](http://cocoapods.org/). Please follow these steps:
+ Installing cocoapods package:
```bat
$ [sudo] gem install cocoapods
$ pod setup
```
+ Adding QNAPFramework cocoapods' spec into your repo list, the magic trick is:
```bat
pod repo add Private-Cocoapods https://github.com/catskytw/PrivateCocoapods.git
```
+ Now, you can search QNAPFramework package via cocoapods:
```bat
$ pod search QNAPFramework
-> QNAPFramework (0.1.6)
   A short description of QNAPFramework.
   pod 'QNAPFramework', '~> 0.1.6'
   - Homepage: https://github.com/catskytw/QNAPFramework
   - Source:   https://github.com/catskytw/QNAPFramework.git
   - Versions: 0.1.6, 0.1.5, 0.1.4, 0.1.0 [QNAPCocoapods repo]
   - Sub specs:
     - QNAPFramework/no-arc (0.1.6)
```
+ Creating your iOS project and editing Podfile. 
```bat
$ edit Podfile
platform :ios, '5.0'
pod 'QNAPFramework',       '~> 0.1.6'
```
+ Installing the dependenies of your project, and always open the .xcworkspace
```bat
$ pod install
$ open App.xcworkspace
```
If you want to upgrade while a new version of QNAPFramework is published, run `pod install` again.
