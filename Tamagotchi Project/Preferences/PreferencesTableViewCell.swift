
import UIKit

class PreferencesTableViewCell: UITableViewCell {

    @IBOutlet weak var preferencesImageView: UIImageView!
    @IBOutlet weak var preferencesNameLabel: UILabel!
    @IBOutlet weak var rightNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
