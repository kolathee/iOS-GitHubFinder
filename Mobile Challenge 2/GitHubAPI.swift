//
//  GitHubAPI.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/6/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class GitHubAPI: NSObject {
    
    var currentRepoRequest:Alamofire.Request?
    var currentUserRequest:Alamofire.Request?
    var currentFollowerRequest:Alamofire.Request?
    var currentOrganizationRequest:Alamofire.Request?
    var currentRepoFromUserRequest:Alamofire.Request?
    
    
    func getRepositories(repoName : String, numberOfRepo:Int, completionHandler : @escaping (Repository) -> Void) {

        let request = Alamofire.request("https://api.github.com/search/repositories?q=\(repoName)&page=1&per_page=\(numberOfRepo)")
        currentRepoRequest?.cancel()
        currentRepoRequest = request
            request.responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                let startIndex = 0
                if let foundRepo = json["total_count"].int {
                    if foundRepo != 0 {
                        var endLoadIndex = startIndex + (numberOfRepo - 1)
                        if (endLoadIndex) > foundRepo {
                            endLoadIndex = foundRepo - 1
                        }
                        for i in startIndex ... endLoadIndex {
                            let imageUrl = json["items"][i]["owner"]["avatar_url"].stringValue
                            Alamofire.request(imageUrl).responseImage { response in
                                if let image = response.result.value {
                                    let repository = Repository(avatar: image,
                                                                name: json["items"][i]["name"].stringValue,
                                                                star: json["items"][i]["stargazers_count"].int!,
                                                                fork: json["items"][i]["forks_count"].int!,
                                                                url: json["items"][i]["html_url"].stringValue)
                                    completionHandler(repository)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func getUser(username : String, numberOfUser : Int, completionHandler : @escaping (User) -> Void) {
        let request = Alamofire.request("https://api.github.com/search/users?q=\(username)&page=1&per_page=\(numberOfUser)")
        currentUserRequest?.cancel()
        currentUserRequest = request
        request.responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                let startIndex = 0
                if let foundUser = json["total_count"].int {
                    if foundUser != 0 {
                        var endLoadIndex = startIndex + (numberOfUser - 1)
                        if (endLoadIndex) > foundUser {
                            endLoadIndex = foundUser - 1
                        }
                        for i in startIndex ... endLoadIndex {
                            let imageUrl = json["items"][i]["avatar_url"].stringValue
                            Alamofire.request(imageUrl).responseImage { response in
                                if let image = response.result.value {
                                    let user = User(username: json["items"][i]["login"].stringValue,
                                                    avatar: image,
                                                    score: json["items"][i]["score"].double!,
                                                    followers_url: json["items"][i]["following_url"].stringValue,
                                                    organizations_url: json["items"][i]["organizations_url"].stringValue,
                                                    repos_url: json["items"][i]["repos_url"].stringValue)
                                    completionHandler(user)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getRepoFromUser(username : String, completionHandler:@escaping (Repository)->Void){
        let request = Alamofire.request("https://api.github.com/users/\(username)/repos?page=1&per_page=100")
        currentRepoFromUserRequest?.cancel()
        currentRepoFromUserRequest = request
        request.responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                let startIndex = 0
                let foundRepo = json.count
                if foundRepo != 0 {
                    let endLoadIndex = foundRepo - 1
                    for i in startIndex ... endLoadIndex {
                        let imageUrl = json[i]["owner"]["avatar_url"].stringValue
                        Alamofire.request(imageUrl).responseImage { response in
                            if let image = response.result.value {
                                let repository = Repository(avatar: image,
                                                            name: json[i]["name"].stringValue,
                                                            star: json[i]["stargazers_count"].int!,
                                                            fork: json[i]["forks_count"].int!,
                                                            url: json[i]["html_url"].stringValue)
                                completionHandler(repository)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func getFollower(username : String, numberOfUser : Int, completionHandler : @escaping (Follower) -> Void){
        let request = Alamofire.request("https://api.github.com/users/\(username)/followers?page=1&per_page=\(numberOfUser)")
        currentUserRequest?.cancel()
        currentUserRequest = request
        request.responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                let startIndex = 0
                let foundUser = json.count
                if foundUser != 0 {
                    var endLoadIndex = startIndex + (numberOfUser - 1)
                    if (endLoadIndex) > foundUser {
                        endLoadIndex = foundUser - 1
                    }
                    for i in startIndex ... endLoadIndex {
                        let imageUrl = json[i]["avatar_url"].stringValue
                        Alamofire.request(imageUrl).responseImage { response in
                            if let image = response.result.value {
                                let user = Follower(username: json[i]["login"].stringValue,
                                                    avatar: image,
                                                    followers_url: json[i]["following_url"].stringValue,
                                                    organizations_url: json[i]["organizations_url"].stringValue,
                                                    repos_url: json[i]["repos_url"].stringValue)
                                completionHandler(user)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getOrganization(username : String, numberOfOrganization : Int, completionHandler:@escaping (Organization)-> Void){
        let request = Alamofire.request("https://api.github.com/users/\(username)/followers?page=1&per_page=\(numberOfOrganization)")
        currentOrganizationRequest?.cancel()
        currentOrganizationRequest = request
        request.responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                let startIndex = 0
                let foundOrgani = json.count
                if foundOrgani != 0 {
                    var endLoadIndex = startIndex + (numberOfOrganization - 1)
                    if (endLoadIndex) > foundOrgani {
                        endLoadIndex = foundOrgani - 1
                    }
                    for i in startIndex ... endLoadIndex {
                        let imageUrl = json[i]["avatar_url"].stringValue
                        Alamofire.request(imageUrl).responseImage { response in
                            if let image = response.result.value {
                                let organization = Organization(login: json[i]["login"].stringValue,
                                                                avatar: image)
                                completionHandler(organization)
                            }
                        }
                    }
                }
            }
        }

    }
    
    func cancelRequest() {
        currentRepoRequest?.cancel()
        currentUserRequest?.cancel()
        currentFollowerRequest?.cancel()
        currentOrganizationRequest?.cancel()
    }
}
