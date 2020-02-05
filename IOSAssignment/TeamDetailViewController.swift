import UIKit

class TeamDetailViewController: UIViewController {

    @IBOutlet weak var teamDescription: UILabel!
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    var image = UIImage()
    var title1 = ""
//    var description1 = ""
   
    @IBOutlet weak var showTeamsCount: UILabel!
    @IBOutlet weak var showVerified: UILabel!
    @IBOutlet weak var showUsername: UILabel!
    @IBOutlet weak var showContact: UILabel!
    
    @IBOutlet weak var nuOfTeams: UILabel!
    @IBOutlet weak var isverified: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var contact: UILabel!
    var usersObj:  Users = Users(id: 1, contact: "1234567890", is_verified: 1, name: "user1", teams_count: 1, username: "user1@test.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showContact.text = usersObj.contact
        showTeamsCount.text = usersObj.teams_count as? String
        showVerified.text = usersObj.is_verified as? String
        showUsername.text = usersObj.username
    
        
//        setUserData(usersObj: usersObj)

    }
    
      
  
}
