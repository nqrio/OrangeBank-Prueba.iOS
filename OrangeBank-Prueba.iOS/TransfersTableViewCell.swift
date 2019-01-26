//
//  TransfersTableViewCell.swift
//  OrangeBank-Prueba.iOS
//
//  Created by Enrique Alfonso on 25/01/2019.
//  Copyright © 2019 Enrique Sureda. All rights reserved.
//

import UIKit

class TransfersTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    func update(with transfer: Transfer) {
        
        // Si hay comisión la aplicamos a la cantidad de la transferencia
        var totalAmount = transfer.amount
        if let fee = transfer.fee {
            totalAmount = transfer.amount + fee
        }
        let totalAmountString = String(totalAmount)
        amountLabel.text = "\(totalAmountString) €"
        
        // Calculamos si la transferencia es ingreso o gasto y aplicamos los colores correspondientes
        let tranferType: TranferType
        totalAmount > 0 ? (tranferType = .ingreso) : (tranferType = .gasto)
        
        switch tranferType {
        case .ingreso: amountLabel.textColor = #colorLiteral(red: 0.3568627451, green: 0.6901960784, blue: 0.4666666667, alpha: 1)
        case .gasto: amountLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
        // Si la transferencia no tiene descripción ponemos Ingreso o Gasto según sea
        if let description = transfer.description {
            if description != "" {
                descriptionLabel.text = transfer.description
            } else {
                switch tranferType {
                case .ingreso: descriptionLabel.text = "Ingreso"
                case .gasto: descriptionLabel.text = "Gasto"
                }
            }
        }
        
        // Le damos formato a la fecha
        dateLabel.text = formatDate(string: transfer.date)
        
        // Embellecemos la celda dándole un aspecto de Card View con una ligera sombra
        bgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.backgroundColor = UIColor.clear
        bgView.layer.cornerRadius = 15.0
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowOpacity = 0.8
    }
    
}

func formatDate(string: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    if let formattedDate = dateFormatter.date(from: string) {
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "es")
        return dateFormatter.string(from: formattedDate)
    }
    return string
}
