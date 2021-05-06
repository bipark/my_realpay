//
//  PayListView.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/16.
//

import SwiftUI


struct PayListView: View {
    var pays: Array<PayModel> = []
        
    init() {
        if self.pays.count == 0 {
            for i in 11...200 {
                let value:Int = i * 100
                pays.append(PayModel(pay: value, nontax: 0, famcnt: 1, childcnt: 0))
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pays, id: \.self) {pay in
                    NavigationLink(destination: PayListDetail(model: pay, showButton: true)){
                        PayListCell(model: pay)
                    }
                }
            }
            .navigationBarTitle("연봉실수령액")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Text("실수령액")
            Image(systemName: "tray.full")
        }
    }
}

struct PayListView_Previews: PreviewProvider {
    static var previews: some View {
        PayListView()
    }
}

