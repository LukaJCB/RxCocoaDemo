//
//  MovieTableController.swift
//  RxCocoaDemo
//
//  Created by Luka on 03.05.16.
//  Copyright © 2016 ltj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieTableController: UIViewController {

    @IBOutlet weak var movieTable: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let movies = initState(addButton.rx_tap)
        
        
        movies.bindTo(movieTable.rx_itemsWithCellIdentifier("movieCell", cellType: MovieTableViewCell.self)) (configureCell: setupCell)
            .addDisposableTo(disposeBag)
        
        
        
        movies.skip(1).subscribeNext { arr in
            self.performSegueWithIdentifier("editMovie", sender: self.movieTable.visibleCells.last)
        }.addDisposableTo(disposeBag)
        
        movieTable.rx_itemSelected.subscribeNext { index in
            self.performSegueWithIdentifier("editMovie", sender: self.movieTable.cellForRowAtIndexPath(index))
        }.addDisposableTo(disposeBag)
        


    }
    
    func setupCell(row: Int, element: Movie, cell: MovieTableViewCell){
        cell.movie = element
        
        element.title.asObservable()
            .bindTo(cell.titleLabel.rx_text)
            .addDisposableTo(self.disposeBag)
        
        element.rating.asObservable()
            .map{String($0)}
            .bindTo(cell.ratingLabel.rx_text)
            .addDisposableTo(self.disposeBag)
    }
    

    let initialMovies: [Movie] = [
        Movie(title: Variable("Die Hard"), rating: Variable(Float(10.0))),
        Movie(title: Variable("Twilight"), rating: Variable(Float(1.0)))
    ]
    
    func initState(addMovie: ControlEvent<Void>) -> Observable<[Movie]> {
        
        let add = addMovie
            .map{_ in  Movie()}
            .scan(initialMovies, accumulator: { (acc,cur) in
                var copy = acc
                copy.append(cur)
                return copy
            })
        
        return add.startWith(initialMovies)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let movieController = segue.destinationViewController as? MovieDetailController {
            if let movieCell = sender as? MovieTableViewCell{
                movieController.movie = movieCell.movie
            }
        }
    }
  
}
