
import UIKit

class ChangeNameViewController: UIViewController {
    
    static let id = "ChangeNameViewController"

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var buttomLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameData = UserDefaults.standard
        title = "\(nameData.string(forKey: UserKeys.defaultName.rawValue) ?? "대장님") 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(userChangeName))
        
        view.backgroundColor = .customBackgroundColor
        
        nameTextField.textColor = .customFontCornerWidthColor
        nameTextField.font = .boldSystemFont(ofSize: 15)
        
        buttomLine.backgroundColor = .customFontCornerWidthColor
        
        nameTextField.text = nameData.string(forKey: UserKeys.defaultName.rawValue) ?? "대장님"
        nameTextField.placeholder = "이름을 설정해주세요"
    
    }
    
    @objc func userChangeName() {
        
        if let name = nameTextField.text {
            if name.isEmpty {
                let alert = UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
            }
        }
        
    }

    // 이름 변경 화면이 나오면
    // 현재 설정된 이름 디폴트로 보여주기
    
}
