//
//  MyPayButton.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/20.
//

import SwiftUI

struct MyPayButton: View {
    @State private var showingAlert = false
    var pay:PayModel
    
    func saveMyPay(){
        var lists = loadSavedPays()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let date1 = dateFormatter.string(from: Date())
        lists.append(SaveModel(date: date1, pay: pay.year_pay))

        savePays(lists)
        sendPostPay(rdate:date1, mypay: String(pay.year_pay))
    }
    
    var body: some View {
        Button("내 연봉으로 등록") {
            showingAlert = true
        }
        .frame(maxWidth: .infinity)
        .alert(isPresented: $showingAlert) {
            let lists = loadSavedPays()
            var title = "연봉을 등록하면 연봉 순위를 확인할 수 있습니다"
            if (lists.count > 0) {
                title = "이미 등록된 연봉자료가 있습니다. 변경 할까요?"
            }
            return Alert(title: Text("내 연봉으로 등록"),
                  message: Text(title),
                  primaryButton: .destructive(Text("확인"), action: {
                    saveMyPay()
                  }),
                  secondaryButton: .cancel(Text("취소")))

        }
    }
}

