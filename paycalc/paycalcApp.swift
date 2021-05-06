//
//  paycalcApp.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/28.
//

import SwiftUI
import Firebase

@main
struct paycalcApp: App {
        
    var body: some Scene {
        WindowGroup {
            ContentView().accentColor(.red)
                .onAppear(perform: {
                    FirebaseApp.configure()
                })
        }
    }
}
