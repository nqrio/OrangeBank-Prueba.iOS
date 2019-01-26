//
//  ViewController.swift
//  OrangeBank-Prueba.iOS
//
//  Created by Enrique Alfonso on 24/01/2019.
//  Copyright © 2019 Enrique Sureda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var transfers = [Transfer]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Llamamos a la web API para recoger las transferencias, comprobamos el formato de fecha, luego las ordenamos por fecha y las cargamos en el Table View
        API.fetchTransfers { (result: [Transfer]) in
            self.transfers = result
            
            DispatchQueue.main.async {
                self.transfers = self.transfers.filter { $0.isDateValid(string: $0.date) }
                self.transfers.sort { $0.date > $1.date }
                
                // Comprobamos si se repite algún ID con el array ya ordenado por fecha. Si se repite alguno nos quedamos con el primero, es decir, con el que tiene fecha más reciente
                var iDs = Set<Int>()
                var uniqueTransfers = [Transfer]()
                for transfer in self.transfers {
                    if !iDs.contains(transfer.id) {
                        uniqueTransfers.append(transfer)
                        iDs.insert(transfer.id)
                    }
                }
                self.transfers = uniqueTransfers
                
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Construimos el Table View con una extension (patrón de diseño DECORATOR)
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transfers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransfersTableViewCell
        
        let transfer = transfers[indexPath.row]
        
        // Le damos formato a la celda con la lógica contenida en TransfersTableViewCell
        cell.update(with: transfer)
        
        return cell
    }
    
    // Destacamos la última transacción realizada en la parte superior de la interfaz
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else {
            return 90
        }
    }
}

// TODO Implementar selección en el Table View con didSelectRowAt para posible navegación

// TODO Implementar animaciones para las celdas del Table View

// TODO Añadir un Navigation Bar para navegar por diferentes ViewControllers
