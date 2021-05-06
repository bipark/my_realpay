//
//  PayFormView.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/19.
//

import SwiftUI

struct PayFormView: View {
    @State var year_pay: String = ""
    @State var non_tax_pay:Int = 100000
    @State private var famiy_count:Int = 1
    @State private var child_count:Int = 0
    @State var model:PayModel = PayModel(pay: 0, nontax: 0, famcnt: 1, childcnt: 0)
    @State private var rows1:Array<PayRowData> = []
    @State private var rows2:Array<PayRowData> = []

    func changeUserInput() {
        if self.year_pay.isNumber {
            if Int(self.year_pay)! >= 1100 {
                self.model = PayModel(pay: Int(self.year_pay)!, nontax: non_tax_pay, famcnt: famiy_count, childcnt: child_count)
            } else {
                self.model = PayModel(pay: 0, nontax: 0, famcnt: famiy_count, childcnt: child_count)
            }
            self.rows1 = []
            self.rows2 = []

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
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("연봉을 입력하세요"),
                        footer:Text("비과세액한도는 10만원입니다")) {
                    
                    HStack {
                        Text("연봉(만원)")
                        VStack (alignment: .trailing) {
                            HStack {
                                TextField("0", text: $year_pay)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: year_pay) { newValue in
                                        changeUserInput()
                                    }
                                Text("만원")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    HStack {
                        Text("비과세액")
                        Spacer()
                        HStack {
                            Text(CommaNumber(price: non_tax_pay) )
                            Text("원")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack {
                        Stepper("부양가족수", value:$famiy_count, in:1...11) {_ in
                            changeUserInput()
                        }
                        Text("\(famiy_count) 명")
                    }
                    HStack {
                        Stepper("20세이하 자녀수", value:$child_count, in:1...11) {_ in
                            changeUserInput()
                        }
                        Text("\(child_count) 명")
                    }
                }
                
                Button(action: {
                    hideKeyboard()
                    changeUserInput()
                }) {
                    Text("계산")
                        .frame(maxWidth: .infinity)
                }

                if self.year_pay.count > 0 {
                    Button(action: {
                        self.year_pay = ""
                        self.model.real_pay = 0
                        changeUserInput()
                        hideKeyboard()
                    }) {
                        Text("지우기")
                            .frame(maxWidth: .infinity)
                    }

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

                    MyPayButton(pay: self.model)
                    MyShareButton(pay: self.model)
                }
            }
            
            .navigationBarTitle("연봉계산기")
            .toolbar {
                Button(action: {
                    hideKeyboard()
                }) {
                    Image(systemName: "arrow.clockwise").imageScale(.large)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Text("연봉계산기")
            Image(systemName: "square.grid.2x2")
        }
        
    }
    
}

struct PayFormView_Previews: PreviewProvider {
    static var previews: some View {
        PayFormView()
    }
}

