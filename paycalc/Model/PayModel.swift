//
//  PayModel.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/16.
//

import Foundation

struct PayModel: Hashable {
    
    let years = "2021년 2월"
    let per1s = "4.5%"
    let per2s = "3.43%"
    let per3s = "11.52%"
    let per4s = "0.8%"

    let per1: Double = 0.045        // 국민연금 비율
    let per2: Double = 0.0343       // 건강보험 비율
    let per3: Double = 0.1152       // 장기요양보험 비율
    let per4: Double = 0.008        // 고용보험 비율
    
    var year_pay: Int = 0           // 연봉
    var real_pay: Int = 0           // 계산용 월급여
    var month_pay: Int = 0          // 월급여
    var tax_main: Int = 0           // 소득세
    var tax_sub: Int = 0            // 지방소득세
    var pension: Int = 0            // 국민연금
    var medins: Int = 0             // 건강보험료료
    var mejins: Int = 0             // 장기요양보험
    var koins: Int = 0              // 고용보험
    var give_pay: Int = 0           // 실수령액
    var fam_count: Int = 1          // 부양기족수
    var calc_fam_count:Int = 0      // 계산용 부양가족수
    var child_count: Int = 0        // 20세 이하 부양가족수
    var sum_ins: Int = 0            // 공제액합계
    
    var nontax_pay = 0              // 비과세액
    let med_default:Int = 5030000   // 의료보험 맥시멈

    // 만원단위로 입력 받는다...
    init(pay:Int, nontax:Int, famcnt:Int, childcnt:Int) {
        year_pay = pay
        real_pay = pay * 10000
        nontax_pay = nontax
        fam_count = famcnt
        child_count = childcnt
        
        calc_fam_count = fam_count
        if (child_count > 0) {
            calc_fam_count = fam_count + (child_count * 2)
        }
        if calc_fam_count > 11 {
            calc_fam_count = 11
        }
        
        month_pay = Int(real_pay / 12)
        if month_pay > nontax_pay {
            month_pay = month_pay - nontax_pay
        }
        
        // 1억보다 적을때와 많을때로 구분
        if pay < 10000 {
            for detail in table {
                let start = detail[0] * 1000
                let end = detail[1] * 1000
                if (month_pay >= start && month_pay < end) {
                    process(detail: detail)
                    break
                }
            }
        } else {
            // 1억보다 많을때
            process(detail: iltable)
        }
    }
    
    mutating func process(detail:Array<Int>) {
        let ilouk = (self.year_pay * 10000)
        
        // 소득세
        self.tax_main = detail[calc_fam_count + 1]
        
        if self.year_pay >= 10000 && self.year_pay < 14000 {
            self.tax_main = self.tax_main + Int(Double(self.real_pay - ilouk) * 0.35)
        } else if self.year_pay >= 14000 && self.year_pay < 28000 {
            self.tax_main = self.tax_main + 1372000 + Int(Double(self.real_pay - ilouk) * 0.38)
        } else if self.year_pay >= 28000 && self.year_pay < 30000 {
            self.tax_main = self.tax_main + 6585600 + Int(Double(self.real_pay - ilouk) * 0.40)
        } else if self.year_pay >= 30000 && self.year_pay < 45000 {
            self.tax_main = self.tax_main + 7369600 + Int(Double(self.real_pay - ilouk) * 0.40)
        } else if self.year_pay >= 45000 && self.year_pay < 87000 {
            self.tax_main = self.tax_main + 13369600 + Int(Double(self.real_pay - ilouk) * 0.42)
        } else if self.year_pay >= 87000 {
            self.tax_main = self.tax_main + 31009600 + Int(Double(self.real_pay - ilouk) * 0.45)
        }
 
        // 지방소득세
        self.tax_sub = Int(Double(tax_main) * 0.1)

        
        let calc1 = month_pay > med_default ? med_default : month_pay
        self.pension = Int(Double(calc1) * per1)
        self.medins = Int(Double(month_pay) * per2)
        self.mejins = Int(Double(medins) * per3)
        self.koins = Int(Double(month_pay) * per4)
        
        self.sum_ins = tax_main + tax_sub + pension + medins + mejins + koins
        self.give_pay = month_pay - sum_ins  + nontax_pay
        

//                print(detail)
//                print("연봉(만원) : \(year_pay)")
//                print("실연봉 : \(real_pay)")
//                print("월급 : \(month_pay)")
//
//                print("소득세 : \(tax_main)")
//                print("지방소득세 : \(tax_sub)")
//
//                print("국민연금 : \(pension)")
//                print("의료보험 : \(medins)")
//                print("장기요양보험 : \(mejins)")
//                print("고용보험 : \(koins)")
//
//                print("실수령액 : \(give_pay)")

    }
    
    func getremark() -> String {
        return "상기 데이터는 \n부양가족수 \(self.fam_count) 명\n20세 이하 자녀수 \(self.child_count) 명\n국민연금(근로자부담금)  \(self.per1s)\n건강보험(근로자부담금) \(self.per2s) \n장기요양보험료(건강보험료의) \(self.per3s)\n고용보험(근로자부담금) \(self.per4s)\n\(self.years) 데이터 기준입니다"
    }
    func getTaxMainComment() -> String {
        return "부양가족 \(self.fam_count), 20세이하 자녀 \(self.child_count)"
    }
    
    func getLocalcomment() -> String {
        return "소득세의 10%"
    }
    func getPer1comment() -> String {
        return "과세금액의 \(per1s)"
    }
    func getPer2comment() -> String {
        return "과세금액의 \(per2s)"
    }
    func getPer3comment() -> String {
        return "건강보험의 \(per3s)"
    }
    func getPer4comment() -> String {
        return "과세금액의 \(per4s)"
    }
    func getTotalcomment() -> String {
        return "\(self.years) 기준 데이터"
    }


}

