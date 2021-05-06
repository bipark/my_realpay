//
//  MyPayView.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/20.
//

import SwiftUI
import Alamofire

struct MyPayView: View {
    @State var myPays:[SaveModel] = []
    @State var rank:String = ""
    @State private var showingAlert = false
    
    var myPay:Int = 0
    
    func getMyRank() {
        self.myPays = loadSavedPays()
        if (self.myPays.count > 0) {
            
            let pay1 = self.myPays[self.myPays.count-1]
            getMyPayRank(mypay: pay1.pay) { (result) -> () in
                self.rank = result
            }
        }
    }
    func getMyPay()->PayModel {
        let mypay2 = self.myPays[self.myPays.count-1]
        return PayModel(pay: mypay2.pay, nontax: 0, famcnt: 1, childcnt: 0)
    }
    
    var body: some View {
        NavigationView {
            Form {
                if (self.myPays.count > 0) {
                    Section(header:Text("내연봉")) {
                        ForEach(self.myPays, id:\.self) {mypay1 in
                            let myModel = PayModel(pay: mypay1.pay, nontax: 0, famcnt: 1, childcnt: 0)
                            NavigationLink(destination: PayListDetail(model: myModel, showButton: false)){
                                HStack {
                                    Text(mypay1.date+" 입력")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(CommaNumber(price: mypay1.pay))
                                        .font(.title2)
                                    Text("만원")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    Section(header:Text("최종연봉")) {
                        let mypay2 = self.myPays[self.myPays.count-1]
                        let myModel = PayModel(pay: mypay2.pay, nontax: 0, famcnt: 1, childcnt: 0)
                        NavigationLink(destination: PayListDetail(model: myModel, showButton: false)){
                            HStack {
                                Text("최종입력")
                                Spacer()
                                Text(CommaNumber(price: mypay2.pay))
                                    .font(.title2)
                                Text("만원")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        HStack(alignment:.center) {
                            Text("귀하의 연봉은 평균 ")
                            Text(rank)
                                .font(.title)
                                .foregroundColor(.accentColor)
                            Text("% 수준입니다")
                        }
                    }
                    
                    Button("삭제") {
                        showingAlert = true
                    }
                    .frame(maxWidth: .infinity)
                    .alert(isPresented: $showingAlert) {
                        return Alert(title: Text("연봉삭제"),
                                     message: Text("입력한 연봉 내역을 전체를 삭제합니다"),
                                     primaryButton: .destructive(Text("확인"), action: {
                                        savePays([])
                                        self.myPays = loadSavedPays()
                                     }),
                                     secondaryButton: .cancel(Text("취소")))
                        
                    }
                    MyShareButton(pay:getMyPay())

                } else {
                    Section {
                        Text("등록한 연봉이 없습니다. 연봉을 등록하면 내 연봉 순위를 조회 할 수 있습니다")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("내연봉은")
            .toolbar {
                Button(action: {
                    self.getMyRank()
                }) {
                    Image(systemName: "arrow.clockwise").imageScale(.large)
                }
            }
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Text("내연봉은")
            Image(systemName: "person")
        }
        .onAppear(perform: {
            self.getMyRank()
        })
    }
}

struct MyPayView_Previews: PreviewProvider {
    static var previews: some View {
        MyPayView()
    }
}

