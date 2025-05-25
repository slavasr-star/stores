import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        guard let url = URL(string: "http://localhost/Sites/api/get_products.php") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        completion(products)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Request error:", error)
            }
        }.resume()
    }
}
