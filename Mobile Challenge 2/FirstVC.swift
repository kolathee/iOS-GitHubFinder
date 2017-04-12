//
//  FirstVC.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/6/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class FirstVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actIndicatorView: UIActivityIndicatorView!
    
    var isLoading = false
    var cellNumber = 0
    
    var users = [User]()
    var repositories = [Repository]()
    var showResults = [Any]()
    var currentSearch = ""
    var searchActive = false
    
    let githubAPI = GitHubAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicatorView.startAnimating()
        actIndicatorView.isHidden = true
        searchBar.returnKeyType = .done
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentSearch = searchText
        getNewData(searchKey:searchText)
    }
    
    func getNewData(searchKey:String) {
        if searchKey != "" {
            
            actIndicatorView.isHidden = false
            isLoading = false
            
            //            pageNumber = 1
            showResults.removeAll()
            cellNumber = 0
            tableView.reloadData()
            
            /// Get Repositories
            githubAPI.getRepositories(repoName: searchKey, numberOfRepo: 100, completionHandler: { (repository) in
                self.actIndicatorView.isHidden = true
                self.showResults.append(repository)
                if self.cellNumber < 10 {
                    let row = self.cellNumber
                    let indexPath = NSIndexPath(row: row, section: 0)
                    self.cellNumber += 1
                    self.tableView?.insertRows(at: [indexPath as IndexPath], with: .fade)
                }
            })
            
            /// Get Users
            githubAPI.getUser(username: searchKey, numberOfUser: 100, completionHandler: { (user) in
                self.actIndicatorView.isHidden = true
                self.showResults.append(user)
                if self.cellNumber < 10 {
                    let row = self.cellNumber
                    let indexPath = NSIndexPath(row: row, section: 0)
                    self.cellNumber += 1
                    self.tableView?.insertRows(at: [indexPath as IndexPath], with: .fade)
                }
            })
            
        } else {
            actIndicatorView.isHidden = true
            githubAPI.cancelRequest()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            searchBar.resignFirstResponder()
            return false
        }
        return true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - offset) < 0 {
            if(!isLoading){
                loadMoreData()
            }
        }
    }
    
    func loadMoreData(){
        if !isLoading {
            isLoading = true
            if cellNumber + 10 <= (showResults.count) {
                for _ in 0..<10 {
                    let row = self.cellNumber
                    let indexPath = NSIndexPath(row: row, section: 0)
                    cellNumber += 1
                    self.tableView?.insertRows(at: [indexPath as IndexPath], with: .fade)
                }
            } else {
                cellNumber = showResults.count
            }
            isLoading = false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// Set User For Cell
        if let user = showResults[indexPath.row] as? User {
            let cell = Bundle.main.loadNibNamed("UserViewCell", owner: self, options: nil)?.first as! UserViewCell
            cell.avatar.image = user.avatar
            circleImage(uiImageV: cell.avatar)
            circleImage(uiImageV: cell.backGroundAvatar)
            setShadow(uiImageV: cell.backGroundAvatar)
            cell.username.text = user.username
            let score = user.score
            let scoreScale = ceil(score/100) * 100
            if scoreScale > 100 {
                cell.starImage.isHidden = false
            }
            cell.score.text = "\(Int(score)) / \(Int(scoreScale))"
            cell.progressBar.setProgress(Float(user.score)/Float(scoreScale), animated: false)
            cell.progressBar.transform = cell.progressBar.transform.scaledBy(x: 1, y: 1.5)
            return cell

            
        ///  Set Repository For Cell
        } else {
            let repo = showResults[indexPath.row] as! Repository
            let cell = Bundle.main.loadNibNamed("RepoViewCell", owner: self, options: nil)?.first as! RepoViewCell
            cell.repoName.text = repo.name
            cell.starNumber.text = "Star: \(repo.star)"
            cell.forkNumber.text = "Fork : \(repo.fork)"
            cell.userImageView.image = repo.avatar
            circleImage(uiImageV: cell.userImageView)
            circleImage(uiImageV: cell.userImageBackgroud)
            setShadow(uiImageV: cell.userImageBackgroud)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = showResults[indexPath.row] as? User {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "userVC") as! UserVC
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "repoVC") as! RepoVC
            vc.url = (showResults[indexPath.row] as! Repository).url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func circleImage(uiImageV : UIImageView){
        uiImageV.layer.cornerRadius = (uiImageV.frame.size.width) / 2
    }
    
    func setShadow(uiImageV : UIImageView){
        uiImageV.layer.shadowOffset = CGSize(width: 0, height: 0)
        uiImageV.layer.shadowColor = UIColor.black.cgColor
        uiImageV.layer.shadowRadius = 3
        uiImageV.layer.shadowOpacity = 0.5
        uiImageV.layer.masksToBounds = false;
        uiImageV.clipsToBounds = false;
    }
}
