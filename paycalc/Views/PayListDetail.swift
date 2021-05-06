//
//  PayListDetail.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/16.
//

import SwiftUI


struct PayListDetail: View {
    @State private var rows1:Array<PayRowData> = []
    @State private var rows2:Array<PayRowData> = []
    var model:PayModel
    var showButton:Bool
        
    var body: some View {
        Form {
            Section(header: Text("급여")) {
                ForEach(rows1, id:\.id) {row1 in
                    payRowAlter(payData: row1)
                }
            }
            
            Section(header: Text("공제액")) {
                ForEach(rows2, id:\.id) {row2 in
                    payRowAlter(payData: row2)
                }
            }
            if showButton {
                MyPayButton(pay: self.model)
            }
            MyShareButton(pay: self.model)
        }
        .navigationTitle("연봉 "+CommaNumber(price:model.year_pay)+" 만원")
        .onAppear(perform: {
            rows1 = []
            rows2 = []
            
            rows1.append(PayRowData(title: "연봉", value: model.year_pay, unit:"만원"))
            rows1.append(PayRowData(title: "월급", value: model.month_pay, unit: "원"))
            rows1.append(PayRowData(title: "비과세액", value: model.nontax_pay, unit: "원"))
            rows1.append(PayRowData(title: "실수령액", value: model.give_pay, unit: "원", textColor:.green))
            
            rows2.append(PayRowData(title: "소득세", value: model.tax_main, unit: "원", comment:model.getTaxMainComment()))
            rows2.append(PayRowData(title: "지방소득세", value: model.tax_sub, unit: "원", comment:model.getLocalcomment()))
            rows2.append(PayRowData(title: "국민연금", value: model.pension, unit: "원", comment:model.getPer1comment()))
            rows2.append(PayRowData(title: "건강보험", value: model.medins, unit: "원", comment:model.getPer2comment()))
            rows2.append(PayRowData(title: "장기요양보험", value: model.mejins, unit: "원", comment:model.getPer3comment()))
            rows2.append(PayRowData(title: "고용보험", value: model.koins, unit: "원", comment:model.getPer4comment()))
            rows2.append(PayRowData(title: "공제액합계", value: model.sum_ins, unit: "원", textColor:.red, comment:model.getTotalcomment() ))

        })
    }
}

struct PayListDetail_Previews: PreviewProvider {
    static var previews: some View {
        PayListDetail(model: PayModel(pay: 1200, nontax: 0, famcnt: 1, childcnt: 0), showButton: true)
    }
}

