//
//  ViewController.swift
//  TableViewTest-1
//
//  Created by apple on 04/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    var products = ["iPhone 6" : "$399",
                    "iPhone 7" : "$449",
                    "iPhone 8" : "$469",
                    "iPhone X" : "$499",
                    "iPhone Xs" : "$529",
                    "iPhone Xr" : "$519",
                    "iPhone Xs Max" : "$599"]
    
    var selectedProducts: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    } 
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
        var keys: [String] = []
        for aKey in products.keys {
            keys.append(aKey)
        }
        cell?.textLabel?.text = keys[indexPath.row]
        cell?.detailTextLabel?.text = products[keys[indexPath.row]]
        
        let index = indexPath.row
        let imagesName = "000" + "\(index + 1)"
        cell?.imageView?.image = UIImage(named: imagesName)
        
        if let product = selectedProducts[keys[indexPath.row]] {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        let productName = selectedCell?.textLabel?.text!
        let productPrice = selectedCell?.detailTextLabel?.text!
        print(productName)
        print(productPrice)
        
        if let product = selectedProducts[productName ?? ""] {
            selectedProducts.removeValue(forKey: productName!)
        } else {
            selectedProducts[productName ?? ""] = productPrice ?? "$0"            
        }
        
        cartButton.title = "\(selectedProducts.count)"

        tableView.reloadData()
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cVC = segue.destination as! CheckOutViewController
        cVC.selectedProducts = selectedProducts
    }
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        <#code#>
//    }
}
