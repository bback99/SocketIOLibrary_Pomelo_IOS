//
//  JSONSerialization.swift
//  SocketIOTest
//
//  Created by shoong on 2017-07-25.
//  Copyright © 2017 SnowBack.com. All rights reserved.
//

//import Foundation
//
//class JSONSerialization {
//    static func JSONStringFromObject(body: Dictionary<String, Int>) -> NSString? {
//        var ret: NSString?
//        //let serializer = NSClassFromString("NSJSONSerialization")
//        let serializer: JSONSerialization? = JSONSerialization()
//        if ((serializer) != nil) {
//            //var data: NSData
//            
//            let JSONData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//            
//            //data = serializer?.data(withJSONObject: body, options: 0)
//            //ret = NSString(initWithData: data, encoding: .NSUTF8StringEncoding)
//            return ret!
//        }
//        return nil
//    }
//}

//+ (NSString *) JSONStringFromObject:(id)object error:(NSError **)error {
//    Class     serializer;
//    NSString *jsonString;
//    
//    jsonString = nil;
//    serializer = NSClassFromString(@"SBJsonWriter");
//    if (serializer) {
//        id writer;
//        
//        writer = [[serializer alloc] init];
//        jsonString = [writer stringWithObject:object];
//        
//        return jsonString;
//    }
//    
//    serializer = NSClassFromString(@"NSJSONSerialization");
//    if (serializer) {
//        NSData *data;
//        
//        data = [serializer dataWithJSONObject:object options:0 error:error];
//        
//        jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        return jsonString;
//    }
//    
//    // lastly, try JSONKit
//    if ([object respondsToSelector:@selector(JSONString)]) {
//        return [object JSONString];
//    }
//    
//    // unable to find a suitable JSON seralizer
//    [NSException raise:SocketIOException format:@"socket.IO-objc requires SBJson, JSONKit or an OS that has NSJSONSerialization."];
//    
//    return nil;
//}
