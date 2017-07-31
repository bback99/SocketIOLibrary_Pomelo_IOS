//
//  ViewController.swift
//  SocketIOTest
//
//  Created by shoong on 2017-07-19.
//  Copyright © 2017 SnowBack.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ISocketHandler {
    
    var socketManager: SocketManager?
    
    @IBOutlet weak var btnConnectToServer: UIButton!
    @IBOutlet weak var btnCreateNJoinRoom: UIButton!
    @IBOutlet weak var btnStartGame: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnCreateNJoinRoom.isEnabled = false
        btnStartGame.isEnabled = false
        
        socketManager = SocketManager(handler: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        socketManager?.disconnect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedConnectToServer(_ sender: UIButton) {
        socketManager?.connectToGateway()
    }
    
    @IBAction func tappedCreateNJoinRoom(_ sender: UIButton) {
    }
    
    @IBAction func tappedStartGame(_ sender: UIButton) {
    }
    
    func onResult(code: Int) {
        switch (code) {
            
        case CodeDefine.WEB_CONNECT_SERVER:
                self.btnConnectToServer.isEnabled = false
                self.btnCreateNJoinRoom.isEnabled = true
            
        case CodeDefine.WEB_DISCONNECT_SERVER:
                self.btnCreateNJoinRoom.isEnabled = false
                self.btnStartGame.isEnabled = false
        
        default: break
        }
    }
}

