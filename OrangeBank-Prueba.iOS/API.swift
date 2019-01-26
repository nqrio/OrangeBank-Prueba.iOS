//
//  API.swift
//  OrangeBank-Prueba.iOS
//
//  Created by Enrique Alfonso on 24/01/2019.
//  Copyright © 2019 Enrique Sureda. All rights reserved.
//

import Foundation

// Creamos la clase API para separar la lógica de la llamada web de nuestro ViewController
class API {
    // Usamos un completion handler para poder acceder a los datos una vez recogidos de la web API
    static func fetchTransfers(_ completion: @escaping (_ result: [Transfer]) -> Void) {
        var modelo = [Transfer]()
        
        guard let url = URL(string: "https://api.myjson.com/bins/1a30k8") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let datos = data, error == nil else {
                print(error?.localizedDescription ?? "Error")
                return }
            do {
                let decoder = JSONDecoder()
                modelo = try decoder.decode([Transfer].self, from: datos)
                completion(modelo)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}

// TODO Extender la clase API con mas funcionalidades web y funciones de persistencia de datos posiblemente usando el patrón de diseño FACADE para mantener el código de gestión de datos separado y bien organizado.
