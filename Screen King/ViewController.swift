//
//  ViewController.swift
//  Screen King
//
//  Created by Benjamin Lewis on 10/21/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [MoviesResponse.Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKClient.shared.getMovies { response in
            switch response.result {
            case .failure(let error): print(error.errorDescription ?? "An error occurred")
            case .success(let response):
                self.movies = response.results
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        cell.titleLabel.text = movies[indexPath.row].title
        return cell
    }

}

