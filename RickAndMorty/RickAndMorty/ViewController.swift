//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Diplomado on 01/12/23.
//

import UIKit

class ViewController: UIViewController {
    let restClient = RESTClient<PaginaterResponse<Character>>(client: Client("https://rickandmortyapi.com"))
    override func viewDidLoad() {
        super.viewDidLoad()
//        restClient.show("/api/character"){ response in
//            //response.results
//            print(response.results)
        restClient.show("/api/character",page: "2") { response in
            print(response.results)
        }
        }
    //query: ["page":"2"]


}

