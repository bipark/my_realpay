//
//  PayListCell.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/17.
//

import SwiftUI

struct PayListCell: View {
    var model:PayModel
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text("연봉(만원)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(CommaNumber(price: model.year_pay))
                    .font(.title)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("실수령액(원)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(CommaNumber(price: model.give_pay))
                    .font(.title)
            }
        }
        
    }
}

struct PayListCell_Previews: PreviewProvider {
    static var previews: some View {
        PayListCell(model: PayModel(pay: 1200, nontax: 0, famcnt: 1, childcnt: 0))
            .previewLayout(.fixed(width: 320, height: 100))
    }
}

