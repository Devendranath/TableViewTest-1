//
//  ViewController.swift
//  TableViewTest-1
//
//  Created by apple on 04/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        if lhs.name == rhs.name && lhs.price == rhs.price && lhs.image == rhs.image {
            return true
        } else {
            return false
        }
    }
    
    var name: String = ""
    var price: String = ""
    var image: String = ""
    
    init(name: String, price: String, image: String) {
        self.name = name
        self.price = price
        self.image = image
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    var products: [Product] = [
                    Product(name: "iPhone 4", price: "399", image: "0001"),
                    Product(name: "iPhone 5", price: "499", image: "0002"),
                    Product(name: "iPhone 6", price: "599", image: "0003"),
                    Product(name: "iPhone 7", price: "699", image: "0004"),
                    Product(name: "iPhone 8", price: "799", image: "0005"),
                    Product(name: "iPhone 9", price: "899", image: "0006"),
                    Product(name: "iPhone X", price: "999", image: "0007"),
                    ]
    
    var selectedProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.aMethod) , for: UIControl.Event.valueChanged)
            
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func aMethod() {
        let newProduct = Product(name: "iPhine xX", price: "1199", image: "0007")
        products.append(newProduct)
        tableView.reloadData()
        tableView.refreshControl?.isHidden = true
        tableView.refreshControl?.removeFromSuperview()
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
        
        let aProduct = products[indexPath.row]
        
        cell?.textLabel?.text = aProduct.name
        cell?.detailTextLabel?.text = aProduct.price
        
        let imagesName = aProduct.image
        cell?.imageView?.image = UIImage(named: imagesName)
        
        if selectedProducts.contains(aProduct) {
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
        let selected = products[indexPath.row]
        if selectedProducts.contains(selected) {
            selectedProducts.remove(at: selectedProducts.firstIndex(of: selected)!)
        } else {
            selectedProducts.append(selected)
        }
        
        cartButton.title = "\(selectedProducts.count)"

        tableView.reloadData()
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cVC = segue.destination as! CheckOutViewController
//        cVC.selectedProducts = selectedProducts
    }
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        <#code#>
//    }
}
