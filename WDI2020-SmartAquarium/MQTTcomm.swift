//
//  MQTTcomm.swift
//  WDI2020-SmartAquarium
//
//  Created by Michal Sulkiewicz on 22/11/2020.
//

import Foundation
import CocoaMQTT

class MQTTcomm: NSObject, CocoaMQTTDelegate, ObservableObject {
    
    var mqttClient: CocoaMQTT?
    @Published var connection: Bool = false
    @Published var messageText = "no message"
    @Published var temp = "00"
    @Published var light: Bool = false
    
    override init() {
        super.init()
        
        mqttSetting()
        
    }
    
    func mqttSetting() {
        let clientID = "WDI2020"
        let host = Credentials.BROKER_ADDRESS
        
        mqttClient = CocoaMQTT(clientID: clientID, host: host, port: 1883)
        
        if let client = mqttClient {
            client.username = Credentials.USERNAME
            client.password = Credentials.PASSWORD
            client.keepAlive = 60
            client.delegate = self
            
            connection = client.connect()
        }
    }
    
    func turnOn() {
           if let client = mqttClient {
               client.publish(Credentials.PUB_SUBJECT, withString: "on")
           }
       }
       
       func turnOff() {
           if let client = mqttClient {
               client.publish(Credentials.PUB_SUBJECT, withString: "off")
           }
       }

    
    
    //MARK: MQTT funcs
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
           
           print("didConnectAck: \(ack)，rawValue: \(ack.rawValue)")
           
           if ack == .accept {
               mqtt.subscribe([(Credentials.SUB_SUBJECT , CocoaMQTTQOS.qos1), (Credentials.PUB_SUBJECT, CocoaMQTTQOS.qos1)])
               messageText = "subscribed"
           }
       }
       
       func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
           print("didPublishMessage with message: \(message.string ?? "")")
       }
       
       func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
           print("didPublishAck with id: \(id)")
           messageText = "published"
       }
       
       func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
           print("didReceivedMessage: \(message.string ?? "") with id \(id)")
           
           switch message.topic {
           case Credentials.SUB_SUBJECT:
               temp = message.string ?? "00"
           case Credentials.PUB_SUBJECT:
               if message.string == "on" {
                   light = true
                   messageText = "light on"
               } else if message.string == "off" {
                   light = false
                   messageText = "light off"
               }
           default:
               print("\(message.topic)")
           }
       }
       
       func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
           print("didSubscribeTopic to \(topics)")
       }
       
       func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
           print("didUnsubscribeTopic to \(topic)")
       }
       
       func mqttDidPing(_ mqtt: CocoaMQTT) {
           print("didPing")

       }
       
       func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
           print("didReceivePong")
       }
       
       func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
           print("mqttDidDisconnect")
           messageText = "disconnected"
       }
}
