import UIKit
import HomeKit

class HomeViewController: UICollectionViewController {
  var homes: [HMHome] = []
  let homeManager = HMHomeManager()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Homes"
    //Creamos un botón en la parte superior izquierda para agregar casas
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newHome(sender:)))//Ejecutamos el método newHome()
    addHomes(homeManager.homes)
    collectionView?.reloadData()
  }
  // regresa el numero de casas que se encuentran en el collection view de home view
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return homes.count
  }
  //Función que agrega una nuevo elemento de tipo casa en la pantalla o un item cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! HomeCell
    cell.setLabel_home(home: homes[indexPath.row])  //Esta funcion duplica la celda de casa cuando se agrega una casa nueva
    
    return cell
  }
  ///Función que nos redirige al AccesoryviewController
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let target = navigationController?.storyboard?.instantiateViewController(withIdentifier: "AccessoryViewController") as! AccessoryViewController
    target.home = homes[indexPath.row]
    navigationController?.pushViewController(target, animated: true) //Reedirige al AccesoryViewController
  }
  
  @objc func newHome(sender: UIBarButtonItem) {
    showInputDialog { homeName in
      
      self.homeManager.addHome(withName: homeName) { home, error in
        
          if error != nil {
            print("Error al agregar una casa")
          } else {
            self.homes.append(home!)
            self.collectionView?.reloadData()
          }
      }
    }
  }
  
  func showInputDialog(_ handler: @escaping ((String) -> Void)) {
    let alertController = UIAlertController(title: "Añadir nueva casa?", message: "Nombre de la nueva casa", preferredStyle: .alert)
    
    //Creamos el boton de crear
    let confirmAction = UIAlertAction(title: "Crear", style: .default) { _ in
        let homeName = alertController.textFields?[0].text
        if homeName == "" {
          print("Nombra la casa")
        } else {
          handler(homeName!)
        }
    }
    
    let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
    
    alertController.addTextField { textField in
      textField.placeholder = "Coloca nombre de la nueva casa"
    }
    //Agregamos botones al AlertController
    alertController.addAction(confirmAction)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true)
  }
  
  func addHomes(_ homes: [HMHome]) {
    for home in homes {
      self.homes.append(home)
    }
    collectionView?.reloadData()
  }
}

