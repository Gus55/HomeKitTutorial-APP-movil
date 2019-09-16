import UIKit
import HomeKit

class HomeCell: UICollectionViewCell {
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var label: UILabel!
  
  func setLabel_home(home:HMHome){
    label.text = home.name
  }

}
