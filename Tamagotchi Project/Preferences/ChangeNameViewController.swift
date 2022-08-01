
import UIKit

class ChangeNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var buttomLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("내 이름 설정화면 viewDidLoad 작동됨")
        
        let nameData = UserDefaults.standard
        // 사용자가 이름을 설정을 하지 않았을 때
        if UserDefaults.standard.string(forKey: UserKeys.userSetupName.rawValue) ==  nil {
            title = "\(nameData.string(forKey: UserKeys.defaultName.rawValue) ?? SafeName.textName)님 새로운 이름 정하기"
            nameTextField.text = nameData.string(forKey: UserKeys.defaultName.rawValue) ?? SafeName.textName
            nameTextField.placeholder = "\(nameData.string(forKey: UserKeys.defaultName.rawValue) ?? SafeName.textName)님 새로운 이름을 설정해주세요"
            print("기본 제공 이름으로 갱신됨")
        } else {
            title = "\(UserDefaults.standard.string(forKey: UserKeys.userSetupName.rawValue)!)님 새로운 이름 정하기"
            nameTextField.text = nameData.string(forKey: UserKeys.userSetupName.rawValue) ?? SafeName.textName
            nameTextField.placeholder = "\(nameData.string(forKey: UserKeys.userSetupName.rawValue) ?? SafeName.textName)님 새로운 이름을 설정해주세요"
            print("사용자가 설정한 이름으로 갱신됨")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(userChangeName))
        
        view.backgroundColor = .customBackgroundColor
        
        nameTextField.textColor = .customFontCornerWidthColor
        nameTextField.font = .boldSystemFont(ofSize: 15)
        
        buttomLine.backgroundColor = .customFontCornerWidthColor
    }
    
    @objc func userChangeName() {
        
        if let name = nameTextField.text {
            if name.isEmpty || name.count < 2 || name.count > 6 { // "고래밥             " 경우 고려 공백 미제거 검사
                
                let alert = UIAlertController(title: "오류", message: "공백 없이 2글자 이상 6글자 이하로 만들 수 있어요.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
                    // self.nameTextField.text?.removeAll() // 텍스트 필드 내용을 제거해주는 게 좋을까 그대로 두는 게 좋을까
                })
                
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
                
            } else {
                
                let nowhitespacesName = name.trimmingCharacters(in: .whitespaces) // 공백 제거 후 한 번 더 검사
                if nowhitespacesName.isEmpty || nowhitespacesName.count < 2 || nowhitespacesName.count > 6 {
                    let alert = UIAlertController(title: "오류", message: "공백 없이 2글자 이상 6글자 이하로 만들 수 있어요.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
                        // self.nameTextField.text?.removeAll()
                    })
                    
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    let saveUserName = UserDefaults.standard
                    saveUserName.set(nowhitespacesName, forKey: UserKeys.userSetupName.rawValue)
                    print("사용자가 설정한 이름 값 저장")
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
        
    }
    
}

