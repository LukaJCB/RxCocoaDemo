//
//  MovieService.swift
//  RxCocoaDemo
//
//  Created by Luka on 03.05.16.
//  Copyright © 2016 ltj. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieService {
    static let initialMovies: [Movie] = [
        Movie(title: Observable.of("Die Hard"), rating: Observable.of(Float(10.0))),
        Movie(title: Observable.of("Twilight"), rating: Observable.of(Float(1.0)))
    ]
    
    static func initState(addMovie: Observable<Any>) -> Observable<[Movie]> {
        
        return addMovie
            .map{_ in  Movie()}
            .scan(initialMovies, accumulator: { (acc,cur) in
                var copy = acc
                copy.append(cur)
                return copy
            })
    }
    
    
}
