import UIKit

class TamagotchiCollectionViewController: UICollectionViewController {
    
    var tamagotchiData = TamagotchiInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "다마고치 선택하기"
        collectionViewLayout()
        
    }

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        <#code#>
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tamagotchiData.tamagotchi.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.id, for: indexPath) as! TamagotchiCollectionViewCell
        
        cell.backgroundColor = .customBackgroundColor
        
        // cell label 디자인
        cell.tamagotchiLabel.font = .boldSystemFont(ofSize: 13)
        cell.tamagotchiLabel.layer.borderWidth = 1
        cell.tamagotchiLabel.layer.borderColor = UIColor.customFontCornerWidthColor.cgColor
        cell.tamagotchiLabel.layer.cornerRadius = 3
        cell.tamagotchiLabel.layer.masksToBounds = true
        cell.tamagotchiLabel.textColor = .customFontCornerWidthColor
        
        let data = tamagotchiData.tamagotchi[indexPath.row]
        cell.configCell(data: data)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: TamagotchiViewController.id) as! TamagotchiViewController
        
        vc.modalPresentationStyle = .overFullScreen // 불투명도 제대로 적용하려면 .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 4
        let itemCount: CGFloat = 3
        let width = (UIScreen.main.bounds.width - (spacing * (itemCount + 1))) / 3
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        self.collectionView.backgroundColor = .customBackgroundColor
        
        collectionView.collectionViewLayout = layout

    }
    
    
}
