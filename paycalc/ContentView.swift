//
//  ContentView.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PayListView()
            PayFormView()
            MyPayView()
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
