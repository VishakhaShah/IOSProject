import UIKit

class EachTeamCell: UITableViewCell {
   
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setTeamData(title : String?, img : UIImage?)
//    {
//        teamTitle.text = title ?? "found nil"
//        teamImageView.image = UIImage(named: img) ?? "nil"
//    }
    
    func setTeamData(eachteamData : Users?)
    {
        teamTitle.text = eachteamData?.name
        idLabel.text = eachteamData?.id as? String
        //teamImageView.image = eachteamData?.description
    }

}
