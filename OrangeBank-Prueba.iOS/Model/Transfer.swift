//
//  Transfer.swift
//  OrangeBank-Prueba.iOS
//
//  Created by Enrique Alfonso on 24/01/2019.
//  Copyright © 2019 Enrique Sureda. All rights reserved.
//

import Foundation

// Creamos el objeto Tranfer que recibirá la info de una transacción en Json
struct Transfer: Codable {
    var id: Int
    var date: String
    var amount: Double
    var fee: Double?
    var description: String?
    
    // Función para validar el formato de fecha
    func isDateValid(string: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let _ = dateFormatter.date(from: string) {
            return true
        } else {
            return false
        }
    }
}

// Creamos una enumeración para definir el tipo de transacción
enum TranferType {
    case gasto
    case ingreso
}
