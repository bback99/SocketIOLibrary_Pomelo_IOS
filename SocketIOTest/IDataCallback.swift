//
//  IDataCallback.swift
//  SocketIOTest
//
//  Created by shoong on 2017-07-20.
//  Copyright © 2017 SnowBack.com. All rights reserved.
//

import Foundation

protocol IDataCallback {
    //void responseData(JSONObject message);
    func responseData(msg: Dictionary<String, Any>)
}
