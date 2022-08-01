import Foundation
import UIKit

// 모든 identifier 수정
protocol IdentityProtocol {
    static var identifier: String { get }
}

// 익스텐션을 활용해 UIViewController에 프로토콜을 채택했다.
extension UIViewController: IdentityProtocol {
    // 익스텐션엔 저장 프로퍼티 사용 불가
    // 타입 프로퍼티를 설정하고 UIViewController의 String(describing:)을 반환하는 Get 구문 적용
    // 호출되는 시점에서 해당 viewController의 identifier 이름이 자동으로 반환된다.
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension UITableViewCell: IdentityProtocol {
    static var identifier: String {
        return String(describing: self) // 연산 프로퍼티로 Get만 사용하기 때문에 Get 블럭 생략
    }
}


extension UICollectionViewCell: IdentityProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

// UITableViewController와 UICollectionViewController는 UIViewController를 상속 받은 이유인지 이미 프로토콜을 채택한 상태라고 표기된다.
extension UITableViewController: IdentityProtocol {
}

extension UICollectionViewController: IdentityProtocol {
}
