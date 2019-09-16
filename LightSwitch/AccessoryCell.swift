import UIKit
import HomeKit

class AccessoryCell: UICollectionViewCell {
  enum LightbulbState: String {
    case on
    case off
  }
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var label: UILabel!
  
  //Modifica el nombre del foco/dispositivo(Es decir el label)
  func setLabelName(accessory: HMAccessory){
    label.text = accessory.name
  }
  
  //Le damos luz al foco de la app
  func setImageLight(accessory: HMAccessory)
  {
    var imageName: LightbulbState
    if let characteristic = accessory.find(serviceType: HMServiceTypeLightbulb, characteristicType: HMCharacteristicMetadataFormatBool),//Indica que la caracteristica tiene valores booleanos.
      let value = characteristic.value as? Bool {
        imageName =  value ? .on : LightbulbState.off
      }
      else {
        imageName = LightbulbState.off
      }
    
    imageView.image = UIImage(named: imageName.rawValue)//Convertimos el valor enum a String
  }
  
}
