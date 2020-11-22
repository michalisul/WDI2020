//
//  ContentView.swift
//  WDI2020-SmartAquarium
//
//  Created by Michal Sulkiewicz on 20/11/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mqtt = MQTTcomm()
    
    var body: some View {
            VStack {
                Spacer()
                Text("\(mqtt.messageText)")
                    .font(Font.system(size: 48, design: .rounded))
                    .padding(.horizontal)
                Spacer()
                Text("\(mqtt.temp)°C")
                    .font(Font.system(size: 120, design: .rounded))
                    .edgesIgnoringSafeArea(.all)
                    .padding(.horizontal)
                Spacer()
                if mqtt.light {
                    Button("Light OFF") {
                        mqtt.turnOff()
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(50)
                    .background(Color(.lightGray))
                    .cornerRadius(12)
                } else {
                    Button("Light ON") {
                        mqtt.turnOn()
                    }
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding(50)
                    .background(Color(.lightGray))
                    .cornerRadius(12)
                }
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

