import UIKit

class DescriptionCVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let reuseIdentifier = "descriptionCollectionVC"
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedManu : String?
    var user : User!
    
    var repositories = [Repository]()
    var organizations = [Organization]()
    var followers = [Follower]()
    
    let githubAPI = GitHubAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedManu
        getDetail()
    }
    
    func getDetail(){
        
        if selectedManu == "Repositories" {
            githubAPI.getRepoFromUser(username: user.username, completionHandler: { (repo) in
                self.repositories.append(repo)
                let row = self.repositories.count - 1
                let indexPath = NSIndexPath(row: row, section: 0)
                self.collectionView.insertItems(at: [indexPath as IndexPath])
            })
        } else if selectedManu == "Organizations" {
            githubAPI.getOrganization(username: user.username, numberOfOrganization: 100, completionHandler: { (organization) in
                self.organizations.append(organization)
                let row = self.organizations.count - 1
                let indexPath = NSIndexPath(row: row, section: 0)
                self.collectionView.insertItems(at: [indexPath as IndexPath])
            })
        } else if selectedManu == "Followers" {
            githubAPI.getFollower(username: user.username, numberOfUser: 300, completionHandler: { (follower) in
                self.followers.append(follower)
                let row = self.followers.count - 1
                let indexPath = NSIndexPath(row: row, section: 0)
                self.collectionView.insertItems(at: [indexPath as IndexPath])
            })
        }
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedManu == "Repositories" {
            return repositories.count
        } else if selectedManu == "Organizations" {
            return organizations.count
        } else /* if selectedManu == "Followers" */ {
            return followers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DescriptionCollectionVC
        
        cell.image.layer.cornerRadius = cell.image.frame.size.width / 2
        cell.imageBound.layer.cornerRadius = cell.imageBound.frame.size.width / 2
        setShadow(uiImageV: cell.imageBound)
        
        if selectedManu == "Repositories" {
            let repo = repositories[indexPath.row]
            cell.detail.text = repo.name
            cell.image.image = #imageLiteral(resourceName: "repo")
            return cell
        } else if selectedManu == "Organizations" {
            let organi = organizations[indexPath.row]
            cell.detail.text = organi.login
            cell.image.image = organi.avatar
            return cell
        } else /* if selectedManu == "Followers" */ {
            let user = followers[indexPath.row]
            cell.detail.text = user.username
            cell.image.image = user.avatar
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func setShadow(uiImageV : UIImageView){
        uiImageV.layer.shadowOffset = CGSize(width: 0, height: 0)
        uiImageV.layer.shadowColor = UIColor.black.cgColor
        uiImageV.layer.shadowRadius = 4
        uiImageV.layer.shadowOpacity = 0.25
        uiImageV.layer.masksToBounds = false;
        uiImageV.clipsToBounds = false;
    }
}
