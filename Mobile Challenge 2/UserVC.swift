//
//  UserVC.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/7/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class UserVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageBound: UIImageView!
    @IBOutlet weak var background: UIView!
    
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowToAllElement()
        self.imageBound?.layer.cornerRadius = (self.imageBound?.frame.size.width)! / 2
        self.userImageView?.layer.cornerRadius = (self.userImageView?.frame.size.width)! / 2
        userImageView.image = user?.avatar
        username.text = user?.username
        
    }
    
    func setShadowToAllElement(){
        setShadow(uiImageV: background, shadowRadius: 10.0, shadowOpacity: 0.25)
        setShadow(uiImageV: tableView, shadowRadius: 4.0, shadowOpacity: 0.25)
        setShadow(uiImageV: imageBound, shadowRadius: 10.0, shadowOpacity: 0.25)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userManu", for: indexPath)
        
        if (indexPath.row == 0){
            cell.textLabel?.text = "Followers"
            return cell
        } else if (indexPath.row == 1){
            cell.textLabel?.text = "Organizations"
            return cell
        } else {
            cell.textLabel?.text = "Repositories"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDescriptionCVC"{
            let collectionVC = segue.destination as! DescriptionCVC
            collectionVC.selectedManu = ((sender as! UITableViewCell).textLabel?.text)!
            collectionVC.user = user
        }
    }
    
    func setShadow(uiImageV : AnyObject, shadowRadius:Float, shadowOpacity:Float){
        uiImageV.layer.shadowOffset = CGSize(width: 0, height: 0)
        uiImageV.layer.shadowColor = UIColor.black.cgColor
        uiImageV.layer.shadowRadius = CGFloat(shadowRadius)
        uiImageV.layer.shadowOpacity = shadowOpacity
        uiImageV.layer.masksToBounds = false;
    }
}
