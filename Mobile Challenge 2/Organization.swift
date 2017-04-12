//
//  Organization.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/8/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class Organization: NSObject {
    
    private var _login : String
    private var _avatar : UIImage
    
    init (login : String, avatar: UIImage) {
        _login = login
        _avatar = avatar
    }
    
    var login : String{
        return _login
    }
    
    var avatar : UIImage{
        return _avatar
    }
}
