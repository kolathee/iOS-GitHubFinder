//
//  Repository.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/6/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class Repository:NSObject {
    
    private var _url : String
    private var _avatar : UIImage
    private var _name : String
    private var _star : Int
    private var _fork : Int
    
    init (avatar:UIImage, name:String, star:Int, fork:Int, url:String) {
        _url = url
        _avatar = avatar
        _name = name
        _star = star
        _fork = fork
    }
    
    var avatar:UIImage {
        return _avatar
    }
    
    var name:String {
        return _name
    }
    
    var star:Int {
        return _star
    }
    
    var fork:Int {
        return _fork
    }
    
    var url:String {
        return _url
    }
}
