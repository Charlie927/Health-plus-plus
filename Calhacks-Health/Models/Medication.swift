//
//  Medication.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import Foundation

struct Medication {
    let name: String
    let amount: Int // mg
    let time: String
}

class MedicationCollection {
    
    var medicine = [Medication]()
    
    init() {
        medicine.append(Medication(name: "Prednisone", amount: 10, time: "0900AM"))
    }
    
}
