//
//  MedicationViewController.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import UIKit

class MedicationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let medCol = MedicationCollection()
    
    override func viewDidLoad() {
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add" {
            let vc = segue.destination as! MedicationDetailViewController
            vc.delegate = self
        }
    }
    
}

extension MedicationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medCol.medicine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicine")!
        
        let name = cell.viewWithTag(1000) as! UILabel
        let aMedicine = medCol.medicine[indexPath.row]
        
        name.text = aMedicine.name
        
        return cell
    }
    
}

extension MedicationViewController: MedicationDetailViewControllerDelegate {
    
    func getMedicine() -> Medication {
        <#code#>
    }
    
    func addMedicine(_ med: Medication) {
        medCol.medicine.append(med)
    }
    
}
