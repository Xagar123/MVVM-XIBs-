//
//  ProductListVC.swift
//  MVVM Example
//
//  Created by Admin on 16/01/23.
//

import UIKit

class ProductListVC: UIViewController {
    
   @IBOutlet weak var productTableView: UITableView!

    private let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()

    }
}

extension ProductListVC {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observerEvent()
        
    }
    
    func initViewModel() {
        viewModel.fetchProduct()
        
    }
    
    //Data binding event observe hoga -> comunication
    func observerEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return}
            
            switch event {
                
            case .loading:
                //indicator show
                print("loading.........")
                
            case .stopLoading:
                //indicator hide
                print("stop loading.............")
            case .dataLoading:
                print("Data loading..............")
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return}
                    print(self.viewModel.product.count)
                    self.productTableView.reloadData()
                }
                print(self.viewModel.product)
            case .error(let error):
                print(error)
            }
            
        }
    }
}

extension ProductListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
       let product = viewModel.product[indexPath.row]
        cell.product = product
        return cell
    }
    
    
    
}
