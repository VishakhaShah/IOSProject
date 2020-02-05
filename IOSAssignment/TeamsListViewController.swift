import UIKit


struct Users: Decodable
{
    var id:Int
    var is_verified: Int
    var name: String
    var teams_count: Int
    var username: String
//
//    init(json: [String: Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        description = json["description"] as? String ?? ""
//    }
    init(id: Int,is_verified: Int,name: String, teams_count: Int, username: String)
    {
        self.id = id
        self.is_verified = is_verified
        self.name = name
        self.teams_count = teams_count
        self.username = username
    }

}

class TeamsListViewController: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView!

    var teamData: Users = Users(id: 1, is_verified: 1, name: "user1", teams_count: 1, username: "user1@test.com")
    var tempUserObj: Users = Users(id: 1, is_verified: 1, name: "user1", teams_count: 1, username: "user1@test.com")

 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController?.navigationItem.hidesBackButton = true

        getTeamNames()
        // Do any additional setup after loading the view.
//        tableView.register(UINib(nibName: "TaskTeamTableViewCell", bundle: nil), forCellReuseIdentifier:"TaskTeamTableViewCell" )
    }

    func getTeamNames()
    {
        //Set up the HTTP request with URLSession
         let session = URLSession.shared
        //let userid = UserDefaults.standard.value(forKey: "userid") as! Int
        let username = "user1@test.com"
        let password = "password"
        let jsonUrl = "https://jedi-taskmanager.herokuapp.com/api/v1/accounts/login?only=contact,id,name,username,teams_count,is_verified"
       
        guard let url = URL(string: jsonUrl) else {
            return
        }
        //Set up the HTTP POST request with URLSession, by adding some data to a URLRequest object.
        let request = NSMutableURLRequest(url: url)
               request.httpMethod = "POST"
        //The request needs a body. This is some data, typically text, that’s sent as part of the request message.
        let paramToSend = "username="+username+"&password="+password
        request.httpBody = paramToSend.data(using: String.Encoding.utf8)
               
               
        //Make the request with URLSessionDataTask, send data to webserver
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
        print(data)
           
        print(response)
            // print(error)
            guard let data = data else { return }
            print(data)
            do {
                let team = try JSONDecoder().decode(Users.self, from: data)
                print(team)
                
            //for team in teams {
                let name_1 = team.name
                let username_1 = team.username
                let id_1 = team.id
               
                let teams_count_1 = team.teams_count
                let is_verified_1 = team.is_verified
               // (id: Int, contact: String,is_verified: Int,name: String, teams_count: Int, username: String)
                let teamObj = Users(id: id_1,
                                    is_verified: is_verified_1,
                                    name: name_1,
                                    teams_count: teams_count_1,
                                    username: username_1)
                self.teamData = teamObj
          //  }
            //check if error is nil or not
            if error != nil {
               // self.handleClientError(error)
                print("========Error Occurred========")
                return
            }
            //The guard let syntax checks if the two conditions evaluate to false, and when that happens the else clause is executed. It literally “guards” that these two conditions are true. It’s easiest to read this as: “Guard that response is a HTTPURLResponse and statusCode is between 200 and 299, otherwise print Error().”
            // check if the HTTP status code is OK
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
                else {
                    //self.handleServerError(response)
                    print("===============Not 200=============")
                    return
                }
            }
            catch
            {
                print("Error: \(error)")
                print("====== Error occurred in json serialization=========")
                return
            }
            print(self.teamData)
            DispatchQueue.main.async {
            //reload the tableview, so that it populates the data came from api
                self.tableView.reloadData()
            }
        }
 
  task.resume()
    }
}

extension TeamsListViewController: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
                return 1
        }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let eachteamData = teamData
            let cell = tableView.dequeueReusableCell(withIdentifier: "EachTeamCell") as! EachTeamCell
            
            cell.setTeamData(eachteamData: eachteamData)
            return cell
        }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            print("===============!!!!")
            self.tempUserObj = teamData
            
            print(self.tempUserObj)
            self.performSegue(withIdentifier: "segue2", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let teamDetailViewController = segue.destination as! TeamDetailViewController
        let users: Users = tempUserObj
        teamDetailViewController.usersObj = users
    }

}
