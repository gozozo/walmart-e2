//
//  ProductListViewController.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import UIKit

/// A view controller that manages the product list view.
/// 
/// This class is responsible for displaying a list of products to the user.
/// It inherits from `UIViewController` and contains the necessary logic to
/// handle the presentation and interaction with the product list.
class ProductListViewController: UIViewController {
    
    var presenter: ProductListPresenterProtocol?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        presenter?.fetchProducts()
    }
    
    /// Configures the table view with necessary settings and properties.
    /// This includes setting delegates, registering cells, and any other
    /// configurations required for the table view to function properly.
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    /// Configures the navigation bar for the ProductListViewController.
    /// This method sets up the appearance and behavior of the navigation bar,
    /// including title, buttons, and other navigation-related elements.
    private func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ProductListViewController: ProductListViewProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfProducts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell,
              let product = presenter?.product(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(with: product)
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToProductDetail(at: indexPath.row)
    }
}
