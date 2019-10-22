//
//  ViewController.swift
//  Screen King
//
//  Created by Benjamin Lewis on 10/21/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [MovieSummary]()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKClient.shared.getMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { movies in
                self.movies = movies
                self.tableView.reloadData()
            }, onError: { error in
                print(error.localizedDescription)
            })
        .disposed(by: disposeBag)
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

