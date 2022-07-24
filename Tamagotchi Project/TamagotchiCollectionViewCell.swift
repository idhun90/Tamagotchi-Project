//
//  TamagotchiCollectionViewCell.swift
//  Tamagotchi Project
//
//  Created by 이도헌 on 2022/07/22.
//

import UIKit

class TamagotchiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiLabel: UILabel!
    @IBOutlet weak var labelBackground: UIView!
    
    static let id = "TamagotchiCollectionViewCell"
    
    func configCell(data: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: data.image)
        tamagotchiLabel.text = data.name
    }
}
