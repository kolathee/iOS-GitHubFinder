//
//  User.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/6/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class User : NSObject {
    
    private var _username : String
    private var _avatar : UIImage
    private var _score : Double
    private var _followers_url : String
    private var _organizations_url :String
    private var _repos_url : String
    
    init (username:String,
          avatar:UIImage,
          score:Double,
          followers_url:String,
          organizations_url:String ,
          repos_url:String) {
        
        _username = username
        _avatar = avatar
        _score = score
        _followers_url = followers_url
        _organizations_url = organizations_url
        _repos_url = repos_url
        
    }
    
    var username : String {
        return _username
    }
    
    var avatar : UIImage {
        return _avatar
    }
    
    var score : Double {
        return _score
    }
    
    var followers_url : String {
        return _followers_url
    }

    var organization_url : String {
        return _organizations_url
    }
    
    var repos_url : String {
        return _repos_url
    }
}
