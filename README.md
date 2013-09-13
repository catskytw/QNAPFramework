### QNAPFramework.
You can use QNAPFramework to build an iOS app quickly which has some functions with your QNAP NAS machines. This framework contains FileManagerAPI, MusicStation API, PhotoStation API, myCloud API and so on. You can just invoke these methods and don't deal with any detail of HTTP request, asynchronism problems, parsing and others. Facing to various HTTP behaviors from many different development teams, this framework is an elegant and carefully designed set of APIs which including RESTful, common Webservice, http response in XML format, http response in JSON format, http header control, credential information and a lot of details. You only simply invoke a method such as:

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

### How to install
