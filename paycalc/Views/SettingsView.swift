//
//  SettingsView.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/26.
//

import SwiftUI

struct SettingsView: View {
    @State var version:String = ""
    @State var model:PayModel = PayModel(pay: 0, nontax: 0, famcnt: 1, childcnt: 0)
        
    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("근로소득, 급여, 연봉")) {
                    Text("근로소득이란 고용계약 또는 이와 유사한 계약에 의하여 근로를 제공하고 받는 대가입니다. 근로자가 일을 하면서 회사가 그 대가로 근로자가 얻게되는 소득을 의미하며, 이 소득에 대해서 세금이 부과됩니다.")
                        .font(.subheadline)
                }
                Section(header:Text("비과세액")) {
                    Text("근로소득 중 세법상 근로소득자에게 혜택을 주기 위하여 세금부과를 제외하는 항목 - 식대, 차량유지보조금, 출산/보육수당 등이 있습니다. 내연봉계산기에서는 10만원을 식대 항목으로 자동 처리합니다")
                        .font(.subheadline)
                }

                Section(header:Text("부양가족")) {
                    Text("부양가족수에 따라 소득세 구간이 달라집니다. 본인포함 부양가족수 - 단 부양가족의 연간소득금액이 100만원이 넘지 않아야 함, 20세이하 자녀수는 - 2배 공제합니다")
                        .font(.subheadline)
                }

                Section(header:Text("공제기준")) {
                    Text("소득세 - 부양가족수에 따른 세액표(\(model.years) 기준").font(.subheadline)
                    Text("지방소득세 - \(model.getLocalcomment())").font(.subheadline)
                    Text("국민연금 - \(model.getPer1comment())").font(.subheadline)
                    Text("건강보험 - \(model.getPer2comment())").font(.subheadline)
                    Text("장기요양보험 - \(model.getPer3comment())").font(.subheadline)
                    Text("고용보험 - \(model.getPer4comment())").font(.subheadline)
                }
                Section(header:Text("앱정보")) {
                    HStack {
                        Text("Maker")
                            .font(.subheadline)
                        Spacer()
                        Text("Practical Inc.")
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Homepage")
                            .font(.subheadline)
                        Spacer()
                        Button("http://pnet.kr") {
                            UIApplication.shared.open(URL(string:"http://pnet.kr")!)
                        }
                        .font(.subheadline)
                    }
                    HStack {
                        Text("Contact")
                            .font(.subheadline)
                        Spacer()
                        Text("rtlink.park@gmail.com")
                            .font(.subheadline)
                    }
                    HStack {
                        Text("Version")
                            .font(.subheadline)
                        Spacer()
                        Text(version)
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("정보")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem {
            Text("정보")
            Image(systemName: "gear")
        }
        .onAppear(perform: {
            if let versionString: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                self.version = versionString
            }
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

