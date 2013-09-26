# QNAPFramework

##Overview
You can use QNAPFramework to build an iOS app quickly which has some functions with your QNAP NAS machines. This framework contains communication module, log system, multimedia streaming machenism and so on. The high level module-stakc chart is as below:<br/>
![image](https://raw.github.com/catskytw/QNAPFramework/master/Doc/highLevelModuleStack.png)<br/>
At ver 0.1, we only develop the communication modules including FileStationManager, MusicStationManager, MyCloudManager APIs and will complete other systems in ver 0.2. Since we focus on the communications and develop this framework for it, let's see the detail in communication:
![image](https://raw.github.com/catskytw/QNAPFramework/master/Doc/CommunicationModuleStack.png)<br/>
You can just invoke these methods and don't deal with any detail of HTTP request, asynchronous/synchronous problems, parsing, error handling and others. Facing to various HTTP behaviors from many different development teams, this framework is an elegant and carefully designed set of APIs which including RESTful, common Webservice, http response in XML format, http response in JSON format, http header control, credential information and a lot of details. For login example, you only simply invoke a method such as:

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
```Objective-C
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

## Installation
The only way to install QNAPFramework is via [Cocoapods](http://cocoapods.org/). Please follow these steps:<br/>
Installing cocoapods package:
```bat
$ [sudo] gem install cocoapods
$ pod setup
```
Adding QNAPFramework cocoapods' spec into your repo list, the magic trick is:
```bat
pod repo add Private-Cocoapods https://github.com/catskytw/PrivateCocoapods.git
```
Now, you can search QNAPFramework package via cocoapods:
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
Creating your iOS project and editing Podfile. Of course, you could give the last version depended on the result of searching by `pod search QNAPFramework` in your Podfile.
```bat
$ edit Podfile
platform :ios, '5.0'
pod 'QNAPFramework',       '~> 0.1.6'
```
Installing the dependenies of your project; ALWAYS open the .xcworkspace or take a lot of compiling error in pods.
```bat
$ pod install
$ open App.xcworkspace
```
If you want to upgrade while a new version of QNAPFramework is published, run `pod install` again.

##Getting Started
Here is the [appleDoc](https://raw.github.com/catskytw/QNAPFramework/master/Doc/index.html) of QNAPFramework. This section will show you how to achieve the features of each module we provide.
###CommunicationManager
show you step by step:
- create an instance of `QNAPCommunicationManager`. You can invoke `[QNAPCommunicationManager share]` for a singleton or `[QNAPCommunicationManager new]` to create an instance and manage it by yourself.
- `[[QNAPCommunication activateAllStation:]` to activate all stations for your NAS. This method would create all instance of stations for you, at ver 0.1.x, which should be fileStationAPIManager, myCloudManager, musicStationAPIManager. If you don't need all station managers at all, you could create them one by one or depended on your demand. The parameter of `[QNAPCommunicationManager activateAllStation:]` is a NSDictionary whose keys are described in appleDoc above. To create eash instance of station should use:
<p/>`[QNAPCommunicationManager factoryForFileStatioAPIManager:]` 
<p/>`[QNAPCommunicationManager factoryForMyCloudManager:withClientId:withClientSecret:]` 
<p/>`[QNAPCommunicationManager factoryForMusicStatioAPIManager:]`
- Now you have the stations stored in `QNAPCommunicationManager`. Giving another pointers for them or using them in singleton directly (e.g. `[QNAPCommunicationManager share].fileStationsManager`).
Actually, There are three session keys in our framework and you should invoke them by yourself, for filling different successBlocks and failureBlocks between them. <br/>
Let's run our login API:<br/>

```Objective-C
[self.fileStationManager loginWithAccount:NAS_ACCOUNT
                             withPassword:NAS_PASSWORD
                         withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult, QNFileLogin *login){
                                 //write your code here while receiving the response success
                             }
                         withFailureBlock:^(RKObjectRequestOperation *operation, QNFileLoginError *error){
                                 //write your code here while the request is failed
                             }];
    
[self.musicStationManager loginForMultimediaSid:NAS_ACCOUNT
                                   withPassword:NAS_PASSWORD
                               withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                               //write your code here while logining for multimedia sid success 
                               }
                               withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                               //write your code here while logining for multimedia sid fail 
                               }];
    
[self.myCloudManager fetchOAuthToken:MyCloud_ACCOUNT
                        withPassword:MyCloud_PASSWORD
                    withSuccessBlock:^(AFOAuthCredential *credential){
                    //write your code here while logining into MyCloud server and fetching OAuth's credential success.
                    } withFailureBlock:^(NSError *error){
                    //write your code here if the request for logining into mycloud server fail.
                    }];

```
As the sample code above, you can invoke some of them by demand.
- If the login is success, now you can invoke any API of stations with success and failure blocks. All APIs http-request are in asynchronous mode and sent one by one from queues. In most of sitiuations, it's make sense that the request sent in asynchronous mode based on AFNetwork library in QNAPFramework. If you really want to run an operation in synchronously, you can send a request by yourself(maybe you have to put it into `RKObjectManager.mainQueue`) and give `waitUntilFinished` or `waitUntilAllOperationsAreFinished` on an `NSOperationQueue`; another choice is adding `[QNAPFrameworkUtil waitUntilConditionBlock:]` until the condition in block is YES, obviously, `waitUntilConditionBlock` should depend on the result of successBlock and failureBlock of the request. Again, both of these are terrible options as they will block the thread you call them on until the operation finishes. This could result in a deadlock if you start them on the main thread and the background job has dependencies on the main thread. Just call these API and leave asynchronized/synchronized problems behind, or you have to embrace synchronous operations wisely and carefully.
 
###UserInterface
<br/>
***
##More Detail for Developers
###Dependency from Cocoapods
As mentioned before, this project uses cocoapods to manage the third party package/lib/framework. At v0.1, there are:<br/>
- [MagicalRecord](https://github.com/magicalpanda/magicalrecord)
- [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- [AFOAuth2Client](https://github.com/nxtbgthng/OAuth2Client)
- [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack)
- [Expecta](https://github.com/specta/expecta)
- [RestKit](https://github.com/RestKit/RestKit)
- [SDWebImage](https://github.com/rs/SDWebImage)
- [SOCKit](https://github.com/jverkoey/sockit)
- [TransitionKit](https://github.com/blakewatters/TransitionKit)
- libwebp<br/>

###AOP:<br/>
In this framework, we implement the [AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming) concept, whose aspects are log, analysis and security check. Our purpose is to decrease cross-cutting concerns which could minimize our maintaining effort.
We provide a tool named QNAPObjectProxy based on NSProxy which reflects any selector of classes by NSInvocation, thus we could insert any jointpoint into any target which could purify the logic in our methods. If you are tracing down the source code or want to improve it, please having some attendtions on this.
You can hook before-interceptor or after-interceptor for any methods in any station's API, including error check, parameters check, error hanling and so on. All interceptors are written in `prag make - Interceptors` in `[QNAPCommunication class]`. 
You can hook the your interceptor if needed. Let's see the sample code:
```
[(QNAPObjectProxy *)classInstance interceptMethodStartForSelector:NSSelectorFromString(@"thumbnailWithFile:withPath:withSuccessBlock:withFailureBlock:withInProgressBlock:")
                                            withInterceptorTarget:self
                                              interceptorSelector:@selector(your_beforeInterceptor:)];
```
This sample code show you which invocation(including target, selector) would be executed before `[MusicStationAPIManager  thumbnailWithFile:withPath:withSuccessBlock:withFailureBlock:withInProgressBlock:]`. You can add your logger, checksum or analysis tool(Google analysis?) into your beforeInterceptor to complete your task and don't need to modify the original QNAPFramework's source code. Be aware, you have to prevent concurrency/deadlock/memory issue by yourself. If you are not very familiar with AOP concept and NSProxy, leave it alone.

###Debug Level:<br/>
In QNAPFramework, we integreated the cocoaLumberjack project for debugLevel. Furthermore, the color console setting by cocoaLumberjack is implemented in `[QNAPCommunicationManager settingMisc:]`. Of course, it works with the XCodePlugin, [XCodeColors](https://github.com/robbiehanson/XcodeColors) written by robbiehanson in XCode 4.x.
![image](https://raw.github.com/catskytw/QNAPFramework/master/Doc/ColorConsole.png). The default debugLevel of QNAPFramework is `LOG_LEVEL_VERBOSE` which would print `DDLogVerbose()` and RestKit/Network. You could reset this debug level by `[QNAPCommunicationManager activateDebugLogLevel:]` in runtime.

###Success/Failure Block Extention
In RESTKit, all methods are given a successBlock `^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){}` and a failureBlock `^(RKObjectRequestOperation *operation, NSError *error){}`.
Consider the one requirement from developers: fast and flexiable, we use a macro to extent the definitions of success/failure blocks.
```objc
#ifndef QNSuccessBlock
#define QNSuccessBlock(blockName,classname)   \
typedef void (^QN##blockName##SuccessBlock)(RKObjectRequestOperation *operation, RKMappingResult * \
mappingResult, classname* obj);
#endif
```
We believe that the macro help you to declare an extension block of the original success block `^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){}` and developers can get the completition-hint in XCode easily. 
![image](https://raw.github.com/catskytw/QNAPFramework/master/Doc/completition-hint.png).


