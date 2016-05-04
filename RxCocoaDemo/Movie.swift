//
//  Movie.swift
//  RxCocoaDemo
//
//  Created by Luka on 03.05.16.
//  Copyright © 2016 ltj. All rights reserved.
//

import Foundation
import RxSwift

class Movie {
    let title: Variable<String>
    let rating: Variable<Float>
    
    init(){
        title  = Variable("")
        rating = Variable(Float(5.0))
    }
    
    init(title: Variable<String>, rating: Variable<Float>){
        self.title = title
        self.rating = rating
    }
}