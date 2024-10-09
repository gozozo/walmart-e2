//
//  ProductListInteractor.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import UIKit
import CoreData

class ProductListInteractor: ProductListInteractorProtocol {
    var presenter: ProductListPresenterProtocol?
    var managedContext: NSManagedObjectContext?
    
    let serviceManager = ServiceManager.shared
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func fetchProducts() {
        if let products = fetchProductsFromCoreData(), products.count > 0 {
            self.presenter?.productsFetched(products: products)
        } else {
            serviceManager.fetchProducts { [weak self] result in
                switch result {
                case .success(let products):
                    self?.saveProducts(products: products)
                    self?.presenter?.productsFetched(products: products)
                case .failure(let error):
                    self?.presenter?.productsFetchFailed(error: error)
                }
            }
        }
    }
    
    private func fetchProductsFromCoreData() -> [Product]? {
        guard let context = managedContext else { return nil }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        
        do {
            let results = try context.fetch(fetchRequest)
            var products: [Product] = []
            
            for case let result as NSManagedObject in results {
                let id = result.value(forKey: "id") as! Int
                let title = result.value(forKey: "title") as! String
                let price = result.value(forKey: "price") as! Double
                let image = result.value(forKey: "image") as! String
                let descrip = result.value(forKey: "descrip") as! String
                let category = result.value(forKey: "category") as! String
                
                let product = Product(id: id, title: title, price: price, description: descrip, category: category, image: image)
                products.append(product)
            }
            
            return products
        } catch {
            print("Error fetching products from Core Data: \(error)")
            return nil
        }
    }
    
    private func saveProducts(products: [Product]) {
        guard let context = managedContext else { return }
        
        for product in products {
            let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)!
            let coreDataProduct = NSManagedObject(entity: entity, insertInto: context)
            
            coreDataProduct.setValue(product.id, forKey: "id")
            coreDataProduct.setValue(product.title, forKey: "title")
            coreDataProduct.setValue(product.price, forKey: "price")
            coreDataProduct.setValue(product.image, forKey: "image")
            coreDataProduct.setValue(product.description, forKey: "descrip")
            coreDataProduct.setValue(product.category, forKey: "category")
        }
        
        do {
            try context.save()
            print("Productos guardados en Core Data")
        } catch {
            print("Error guardando productos en Core Data: \(error)")
        }
    }
}
