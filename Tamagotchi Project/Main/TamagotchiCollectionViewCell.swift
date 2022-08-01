
import UIKit

class TamagotchiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiLabel: UILabel!
    @IBOutlet weak var labelBackground: UIView!
    
    func configCell(data: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: data.image)
        tamagotchiLabel.text = data.name
    }
}
