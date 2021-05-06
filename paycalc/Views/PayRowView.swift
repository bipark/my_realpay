//
//  PayRowView.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/25.
//

import SwiftUI

struct PayRowData: Identifiable {
    var id = UUID()
    var title:String
    var value:Int
    var unit:String
    var textColor:Color = Color.black
    var comment:String = ""
}

struct payRowAlter: View {
    var payData: PayRowData
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(payData.title)
                    .font(.subheadline)
                if (payData.comment != "") {
                    Text(payData.comment)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            HStack {
                Text(CommaNumber(price: payData.value))
                    .font(.title)
                    .foregroundColor(.primary)
                Text(payData.unit)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.all, 2)
        }
    }
}

