import UIKit
import HomeKit

class AccessoryViewController: UICollectionViewController {
  let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))//Creamos un circule de carga
  var accessories: [HMAccessory] = []
  var home: HMHome?
  
  // For discovering new accessories
  let browser = HMAccessoryBrowser()//Nos ayudara a descubrir nuevos dispositivos en la red
  var discoveredAccessories: [HMAccessory] = []//Conjunto de dispositivos en nuestra casa
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "\(home?.name ?? "") Accessories"
    //Agregamos un boton para realizar la búsqueda de los dispositios en nuestra red
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(discoverAccessories(sender:)))
    
    loadAccessories()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return accessories.count
  }
  /**
   * Se agrega una celda a un layout de tipo Collection View
   */
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! AccessoryCell
    cell.setLabelName(accessory:  accessories[indexPath.row])
    cell.setImageLight(accessory: accessories[indexPath.row])
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  {
    collectionView.deselectItem(at: indexPath, animated: true)
    
    let accessory = accessories[indexPath.row]
    
    //Cuando seleccionemos un accesorio en la app y este se encuentre....
    //En caso contrario arrojara un mensaje de error
    if let characteristic = accessory.find(serviceType: HMServiceTypeLightbulb, characteristicType: HMCharacteristicMetadataFormatBool)//Devuelve HMCharacteristic
    {
      let toggleState = (characteristic.value as! Bool) ? false : true//En caso de que el foco se encuentre apagado, se enciende
      
      characteristic.writeValue(NSNumber(value: toggleState)) { error in//Con NSNumber convertimos toggleState de booleano a int
        if error != nil {//En caso de error arrojar mensaje
          print("Error al intentar actualizar la característica del servicio.")
        }
        collectionView.reloadData()
      }
    } else {
      print("No se pudo encontrar el gadget especificado desde el código")
    }
    
  }
  //Carga accesorios de home.accesssories en nuestro array miembro de clase:HMAccessory
  private func loadAccessories() {
    if let homeAccessories = home?.accessories {//Si exiten accesorios en nuestra casa
      for accessory in homeAccessories {//Recorremos el arryar
          accessories.append(accessory)//HMAccessory
      }
    }
    collectionView?.reloadData()
  }
  
  @objc func discoverAccessories(sender: UIBarButtonItem) {
    activityIndicator.startAnimating()//Iniciamos la animación del circulo de carga
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)//Colocamos como un botón en la parte superior derecha el icono
    
    //discoveredAccessories.removeAll()
    browser.delegate = self
    browser.startSearchingForNewAccessories()//Iniciamos la busquéda de nuevos dispositivos
    perform(#selector(stopDiscoveringAccessories), with: nil, afterDelay: 10)
  }
  
  @objc private func stopDiscoveringAccessories() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(discoverAccessories(sender:)))
    if discoveredAccessories.isEmpty {
      let alert = UIAlertController(title: "No Accessories Found",
                                    message: "No Accessories were found. Make sure your accessory is nearby and on the same network.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      present(alert, animated: true)
    } else {
      let homeName = home?.name
      let message = """
                    Found a total of \(discoveredAccessories.count) accessories. \
                    Add them to your home \(homeName ?? "")?
                    """
      
      let alert = UIAlertController(
        title: "Accessories Found",
        message: message,
        preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Cancel", style: .default))
      alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
        self.addAccessories(self.discoveredAccessories)
      })
      present(alert, animated: true)
    }
  }
  
  private func addAccessories(_ accessories: [HMAccessory]) {
    for accessory in accessories
    {
        home?.addAccessory(accessory) { error in
            if let error = error {
              print("Failed to add accessory to home: \(error.localizedDescription)")
            } else {
              self.loadAccessories()
            }
      }
    }
  }
}

extension AccessoryViewController: HMAccessoryDelegate {
  func accessory(_ accessory: HMAccessory, service: HMService, didUpdateValueFor characteristic: HMCharacteristic) {
    collectionView?.reloadData()
  }
}

extension AccessoryViewController: HMAccessoryBrowserDelegate {
  func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
    discoveredAccessories.append(accessory)
  }
}

extension HMAccessory {
  func find(serviceType: String, characteristicType: String) -> HMCharacteristic? {
    return services//services:HMService
      .filter { $0.serviceType == serviceType }//Devuelve los elementos que cumplan con la condición de ser un servicio de tipo foco
      .flatMap { $0.characteristics }//Devuelve la caracteristica de cada objeto de tipo servico
      .first { $0.metadata?.format == characteristicType }//Devuelve el primer elemento que satisface la condiciòn
    
    //En resumen podemos decir que esta cadena de funciones devuelve el conjunto de elementos que son del tipo
    //de servicio HMServiceTypeLightbulb
  }
}
