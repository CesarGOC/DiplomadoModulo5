//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Diplomado on 01/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var numberPage: Int = 1
    var currentPage = 1
    var isFetchingData = false
    
    
    let restClient = RESTClient<PaginaterResponse<Character>>(client: Client("https://rickandmortyapi.com"))
    
    var characters: [Character]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        restClient.show("/api/character",page: "1") { response in
            print(response.results)
            self.characters = response.results
        }
       
    }
    
    func fetchData() {
            guard !isFetchingData else { return }

            isFetchingData = true

            let page = String(currentPage)

            // Llamar a la API para obtener datos de la página actual
            restClient.show("/api/character", page: page) { response in
                self.characters! += response.results
                self.isFetchingData = false
                self.tableView.reloadData()
            }
        }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = characters?[indexPath.row].name
        cell.detailTextLabel?.text = characters?[indexPath.row].species
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Implementar lógica para cargar datos adicionales cuando se prefetchean celdas
                // indexPaths contiene las indexPaths de las celdas que se prefetchearán
        let needsFetch = indexPaths.contains { $0.row >= self.characters!.count - 5 }
                if needsFetch {
                    currentPage += 1
                    fetchData()
                }
    }
}


