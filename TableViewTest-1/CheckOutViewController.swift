//
//  CheckOutViewController.swift
//  TableViewTest-1
//
//  Created by apple on 04/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController {

    var selectedProducts: [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


extension CheckOutViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
        var keys: [String] = []
        for aKey in selectedProducts.keys {
            keys.append(aKey)
        }
        cell?.textLabel?.text = keys[indexPath.row]
        cell?.detailTextLabel?.text = selectedProducts[keys[indexPath.row]]
        
//        let index = indexPath.row
//        let imagesName = "000" + "\(index + 1)"
//        cell?.imageView?.image = UIImage(named: imagesName)
        
//        if let product = selectedProducts[keys[indexPath.row]] {
//            cell?.accessoryType = .checkmark
//        } else {
//            cell?.accessoryType = .none
//        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var keys: [String] = []
        for aKey in selectedProducts.keys {
            keys.append(aKey)
        }
        selectedProducts.removeValue(forKey: keys[indexPath.row])
        tableView.reloadData()
    }
    
    @IBAction func proceedClicked() {
        let alertController = UIAlertController(title: "Checkout", message: "Your payment is successfull of \(100)", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let pVC = self.navigationController?.viewControllers[0] as! ViewController
           pVC.selectedProducts = []
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

