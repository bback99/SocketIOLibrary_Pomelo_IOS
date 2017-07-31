//
//  SocketManager.swift
//  SocketIOTest
//
//  Created by shoong on 2017-07-19.
//  Copyright © 2017 SnowBack.com. All rights reserved.
//

import Foundation
import SocketIO

public typealias MSGCallbackFunction = (_ msg: Dictionary<String, Any>) -> Void

class SocketManager {
    
    var socket: SocketIOClient? // = SocketIOClient(socketURL: URL(string: "http://localhost:3014")!, config: [.log(true), .compress])
    var reqID: Int = 0
    //var mapCBs: Dictionary = Dictionary<Int, IDataCallback>()
    var mapCBs: Dictionary = Dictionary<Int, MSGCallbackFunction>()
    var socketHandler: ISocketHandler?
    var status: Int = 0
    
    let ROUTE_GATE = "gate.gateHandler.queryEntry"
    let ROUTE_CONNECTOR = "connector.entryHandler.entry"
    let ROUTE_ROOM = "room.roomHandler.notifyData"
    
    init(handler: ISocketHandler?) {
        socket = nil
        socketHandler = handler
    }
    
    func bindDefaultMethods() {
        if socket != nil {
            socket?.on(clientEvent: .connect) { data, ack in
                print("socket conncted.")
                
                //let retStr = Protocol.encode(id: 1293923, route: "gateway.adbd.eeee", body: "JSONDATA")
                //print(retStr)
                
                //self.socketHandler?.onResult(code: CodeDefine.WEB_CONNECT_SERVER)
                
                if self.status == 0 {        // from Gateway
                    var body: Dictionary? = Dictionary<String, Any>()
                    body?["uid"] = 1
                    body?["timestamp"] = 1231231
                    
                    self.requestWithRoute(route: self.ROUTE_GATE, body: body!, cb: { (msg: Dictionary<String, Any>) -> (Void) in
                        print(msg)
                        self.status = 1
                        
                        //var url = "http://" + msg["host"] as! String + ":" + msg["port"] as! String
                        var url = "http://"
                        let host = msg["host"] as! String
                        let port = msg["port"] as! Int
                        url += host + ":" + String(port)
                        self.connectToServer(url: url)
                    })
                }
                else {      // from Connector
                    self.status = 0
                    
                    var body: Dictionary? = Dictionary<String, Any>()
                    body?["rid"] = 1
                    body?["username"] = "SnowBack"
                    
                    self.requestWithRoute(route: self.ROUTE_CONNECTOR, body: body!, cb: { (msg: Dictionary<String, Any>) -> (Void) in
                        print(msg)
                        
                    })
                }
            }
            
            socket?.on(clientEvent: .disconnect) { data, ack in
                print("socket diconncted.")
                self.socketHandler?.onResult(code: CodeDefine.WEB_DISCONNECT_SERVER)
            }
            
            socket?.on("message") { data, ack in
                let jsonString: String = data[0] as! String
                //print(jsonString)
                
                let json: NSData? = jsonString.data(using: .utf8) as NSData?
                do {
                    let jsonData: Any = try JSONSerialization.jsonObject(with: json! as Data, options: .mutableContainers)
                    
                    if jsonData is NSArray {
                        self.processMessageBatch(bodies: jsonData as! NSArray)
                    }
                    else if jsonData is Dictionary<String, Any> {
                        self.processMessage(body: jsonData as! Dictionary<String, Any>)
                    }
                    else {
                        print("parse error")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func connectToGateway() {
        connectToServer(url: "http://localhost:3014")
    }
    
    func connectToServer(url: String) {
        socket = SocketIOClient(socketURL: URL(string: url)!, config: [.log(false), .compress])
        socket!.connect()
        
        bindDefaultMethods()
    }
    
//    func connectToServer(url: String, callback: IDataCallback?) {
//        if callback != nil {
//            //self.mapCBs["onConnect"] = callback
//        }
//        connectToServer(url: url)
//    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    func requestWithRoute(route: String, body: Dictionary<String, Any>, cb: MSGCallbackFunction?) {
        if cb != nil {
            reqID += 1
            //let key: String = String(reqID)
            mapCBs[reqID] = cb
            sendMessageWithReqId(id: reqID, route: route, body: body)
        }
        else {
            notifyWithRoute(route: route, body: body)
        }
    }
    
    func notifyWithRoute(route: String, body: Dictionary<String, Any>) {
        sendMessageWithReqId(id: 0, route: route, body: body)
    }
    
    func sendMessageWithReqId(id: Int, route: String, body: Dictionary<String, Any>) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions(rawValue: 0))
            let txtJSON = String(data:jsonData, encoding: .utf8)
            socket!.emit("message", Protocol.encode(id: id, route: route, body: txtJSON!))
        } catch {
            print(error.localizedDescription)
        }
    }

    func processMessageBatch(bodies: NSArray) {
        for body in bodies {
            processMessage(body: body as! Dictionary<String, Any>)
        }
    }
    
    func processMessage(body: Dictionary<String, Any>) {
        if let id = body["id"] as! Int? {
            if let cb = self.mapCBs[id] {
                cb(body["body"] as! Dictionary<String, Any>)
            }
        }
    }
}



