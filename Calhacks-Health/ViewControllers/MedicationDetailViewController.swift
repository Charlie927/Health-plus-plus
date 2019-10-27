//
//  MedicationDetailViewController.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import UIKit

protocol MedicationDetailViewControllerDelegate: class {
    func addMedicine(_ med: Medication)
    func getMedicine() -> Medication
}

class MedicationDetailViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    
    var isAdding = false
    
    weak var delegate: MedicationDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        if !isAdding {
            let theMed = delegate?.getMedicine()
            nameText.text = theMed?.name
            amountText.text = String((theMed?.amount)!)
            timeText.text = theMed?.time
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        let newMed = Medication(name: nameText.text!, amount: Int(amountText.text!)!, time: timeText.text!)
        delegate?.addMedicine(newMed)
    }
    
}
