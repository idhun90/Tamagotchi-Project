//enum PreferencesList: Int, CaseIterable {
//    case preferencesName, image
//
//    switch self {
//    case .preferencesName
//    }
//}
import UIKit

class PreferencesTableViewController: UITableViewController {
    
    static let id = "PreferencesTableViewController"
    
    let preferenceName = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"]
    let preferenceImage = ["pencil", "moon.fill", "arrow.clockwise"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("설정화면 viewDidLoad 작동됨")
        
        tableView.backgroundColor = .customBackgroundColor
        navigationItem.title = "설정"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData() // 사용자가 이름을 설정했을 때 테이블 뷰 오른쪽 레이블 데이터 갱신
    }
    
    
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
            if UserDefaults.standard.string(forKey: UserKeys.userSetupName.rawValue) ==  nil {
                let defaultName = UserDefaults.standard
                cell.rightNameLabel.text = defaultName.string(forKey: UserKeys.defaultName.rawValue) ?? "대장"
                print("기본 제공 이름으로 설정")
            } else {
                cell.rightNameLabel.text = UserDefaults.standard.string(forKey: UserKeys.userSetupName.rawValue)
                print("사용자가 설정한 이름으로 갱신")
            }
        } else {
            cell.rightNameLabel.text = "" // 첫행만 오른쪽 레이블 표기 목적
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // '내 이름 설정하기' 항목 선택 시
        if indexPath.row == 0 {
            
            let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: ChangeNameViewController.id) as! ChangeNameViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // '다마고치 변경하기' 항목 선택 시
        if indexPath.row == 1 {
            
            let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TamagotchiCollectionViewController.id) as! TamagotchiCollectionViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        // '데이터 초기화' 항목 선택 시
        if indexPath.row == 2 {
            // 알람 추가
            let alert = UIAlertController(title: "데이터 초기화", message: "모든 데이터가 삭제됩니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                
                // 저장된 데이터 모두 삭제
                let selectedData = UserDefaults.standard
                selectedData.removeObject(forKey: UserKeys.TamagotchiName.rawValue)
                selectedData.removeObject(forKey: UserKeys.defaultName.rawValue)
                selectedData.removeObject(forKey: UserKeys.userSetupName.rawValue)
                print("모든 데이터가 초기화되었습니다.")
                
                let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowsScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: "Tamagotchi", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: TamagotchiCollectionViewController.id) as! TamagotchiCollectionViewController
                
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
}



// 사용자가 처음 앱을 실행했을 때, 앱 내부에서 미리 설정된 이름 중 랜덤으로 선택해서 '내 이름' 설정해주기
// 사용자가 '내 이름'을 변경했을 때, 사용자가 변경한 이름으로 보여주도록 설정하기

func creatRightNameByUser() {
    
}
