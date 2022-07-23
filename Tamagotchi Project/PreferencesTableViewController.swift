//enum PreferencesList: Int, CaseIterable {
//    case preferencesName, image
//
//    switch self {
//    case .preferencesName
//    }
//}
import UIKit

class PreferencesTableViewController: UITableViewController {
    
    let preferenceName = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"]
    let preferenceImage = ["pencil", "moon.fill", "arrow.clockwise"]
    
    var myName: [String] = ["고래밥", "칙촉", "냉방병 걸린 스폰지밥", "비둘기", "작심삼일", "갑오징어"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .customBackgroundColor

    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return preferenceName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreferencesTableViewCell.id, for: indexPath) as? PreferencesTableViewCell else { return UITableViewCell()}
        
        // UI
        cell.backgroundColor = .customBackgroundColor
        cell.preferencesImageView.tintColor = .customFontCornerWidthColor
        cell.preferencesNameLabel.textColor = .customFontCornerWidthColor
        cell.preferencesNameLabel.font = .boldSystemFont(ofSize: 15)
        cell.rightNameLabel.textColor = .customFontCornerWidthColor
        cell.rightNameLabel.font = .systemFont(ofSize: 13)
        
        // 데이터
        cell.preferencesImageView.image = UIImage(systemName: preferenceImage[indexPath.row])
        cell.preferencesNameLabel.text = preferenceName[indexPath.row]
        
        if cell.preferencesNameLabel.text == preferenceName[0] {
            // 사용자가 첫 설정을 하지 않았을 때
            cell.rightNameLabel.text = myName.randomElement()!
            // 사용자가 이름을 변경했을 때
        } else {
            cell.rightNameLabel.text = ""
        }
       
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// 사용자가 처음 앱을 실행했을 때, 앱 내부에서 미리 설정된 이름 중 랜덤으로 선택해서 '내 이름' 설정해주기
// 사용자가 '내 이름'을 변경했을 때, 사용자가 변경한 이름으로 보여주도록 설정하기
