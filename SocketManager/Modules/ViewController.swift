//
//  ViewController.swift
//  SocketManager
//
//  Created by Furkan Beyhan on 6.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func socketStatChangeButtonClicked(_ sender: Any) {
        let socketStatus = SocketService.checkStatus()
        switch socketStatus {
        case .notConnected:
            SocketService.connectAPI()
        case .disconnected:
            SocketService.connectAPI()
        case .connecting:
            print("connecting already")
        case .connected:
            SocketService.disconnectAPI()
        default:
            break
        }
    }
    
}

