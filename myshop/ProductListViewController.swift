import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var products: [Product] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Товары"
        view.backgroundColor = .white
        setupTableView()
        fetchProducts()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func fetchProducts() {
        APIService.shared.fetchProducts { [weak self] products in
            self?.products = products
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.brand) \(product.model) — \(product.price)₽"
        return cell
    }
}

