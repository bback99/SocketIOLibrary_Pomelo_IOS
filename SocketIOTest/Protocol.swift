//
//  Protocol.swift
//  SocketIOTest
//
//  Created by shoong on 2017-07-19.
//  Copyright © 2017 SnowBack.com. All rights reserved.
//

import Foundation

class Protocol {
    static func encode(id: Int, route: String, body: String) -> String {
        var retMsg: String? = nil
        
        if route.characters.count > 255 {
            //[NSException raise:PomeloException format:@"Pomelo: route length is too long!"];
        }
        else {
            retMsg = NSString(format:"%C%C%C%C%C%@%@",
                               (id >> 24) & 0xFF,
                               (id >> 16) & 0xFF,
                               (id >> 8) & 0xFF,
                               id & 0xFF,
                               route.characters.count,
                               route,
                               body) as String

            print(retMsg!)
        }
        return retMsg!
    }
}
