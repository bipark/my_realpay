//
//  SaveModel.swift
//  paycalc
//
//  Created by Park Billy on 2021/04/20.
//

import Foundation

struct SaveModel:Codable, Hashable {
    var id: UUID = UUID()
    let date: String
    let pay: Int
}

func loadSavedPays() -> [SaveModel] {
    guard let encodedData = UserDefaults.standard.array(forKey: "saves") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(SaveModel.self, from: $0) }
}

func savePays(_ pays:[SaveModel]){
    let data = pays.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "saves")
}

