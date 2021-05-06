//
//  MyShareButton.swift
//  paycalc
//
//  Created by Park Billy on 2021/05/05.
//

import SwiftUI

struct MyShareButton: View {
    var pay:PayModel

    func actionSheet() {
        guard let data = URL(string: "http://pnet.kr/realpay/"+String(self.pay.year_pay)) else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }

    var body: some View {
        Button(action: actionSheet){
            Text("공유하기")
        }
        .frame(maxWidth: .infinity)
    }
}
