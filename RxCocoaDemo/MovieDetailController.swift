//
//  ViewController.swift
//  RxCocoaDemo
//
//  Created by Luka on 03.05.16.
//  Copyright © 2016 ltj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: Movie?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movie?.rating.asObservable()
            .bindTo(ratingSlider.rx_value)
            .dispose()
        
        let rating = ratingSlider.rx_value.map { Float(round(10 * $0)/10) }
        
        rating
            .bindTo(movie!.rating)
            .addDisposableTo(disposeBag)
        rating
            .map{String($0)}
            .bindTo(ratingLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        movie?.title.asObservable()
            .bindTo(titleField.rx_text)
            .dispose()
        
        
        titleField.rx_text
            .bindTo(movie!.title)
            .addDisposableTo(disposeBag)
        
    }
    
    

}

