//
//  SocketService.swift
//  SocketService
//
//  Created by Furkan Beyhan on 6.04.2022.
//

import Foundation
import SocketIO
import SwiftyJSON

final class SocketService : NSObject {
    
    static let url = "SOCKET_URL_IS_HERE"
    static let token = "SOCKET_TOKEN_IS_HERE"
    static let params = ["auth": token]
    
    static let manager = SocketManager(socketURL: URL(string: url)!, config: [.forceWebsockets(true)])
    static var socket : SocketIOClient?
    
    static func connectAPI() {
        
        socket = manager.defaultSocket
        
        socket?.on(clientEvent: .connect) {data, ack in
            print(data,"socket Event: connected")
        }
        
        socket?.on(clientEvent: .disconnect, callback: { data, ack in
            print(data,"socket Event: disconnect")
        })
        
        socket?.on("Error") { (data, ack) in
            if !data.isEmpty {
                let dataJSON = JSON(data)[0]
                print("socket Event: Error:",dataJSON)
            }
        }
        
        socket?.connect()
        
    }
    
    static func disconnectAPI() {
        if let socket = socket {
            socket.disconnect()
        }
    }
    
    static func checkStatus() -> SocketIOStatus {
        if let socket = socket {
            let stat = socket.status
            return stat
        }
        return .notConnected
    }
    
}
