//
//  ISocketHandler.swift
//  SocketIOTest
//
//  Created by shoong on 2017-07-20.
//  Copyright © 2017 SnowBack.com. All rights reserved.
//

import Foundation

protocol ISocketHandler {
    func onResult(code: Int)
    //func onSendData(JSONObject message);
}
