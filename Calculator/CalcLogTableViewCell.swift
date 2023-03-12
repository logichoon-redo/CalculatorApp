//
//  CalcLogTableViewCell.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/12.
//

import UIKit

class CalcLogTableViewCell: UITableViewCell {

    var logLabel = UILabel()
    var logValue = UILabel()
    var dateLabel = UILabel()
    var dateValue = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureSubviews()
        print("called configureSubviews" )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    

}

extension CalcLogTableViewCell: ConfigureSubviewsCase {
    func configureSubviews() {
        createSubviews()
        addSubviews()
        setupLayouts()
    }
    
    func createSubviews() {
       
    }
    
    func addSubviews() {
        self.addSubview(logLabel)
        self.addSubview(logValue)
        self.addSubview(dateLabel)
        self.addSubview(dateValue)
    }
    
    func setupLayouts() {
        setupSubviewsLayouts()
        setupSubviewsConstraints()
    }
    
}
extension CalcLogTableViewCell: SetupSubviewsLayouts {
    func setupSubviewsLayouts() {
        logLabel.text = "Log: "
        
        dateLabel.text = "Date: "
    }
    
    
}
extension CalcLogTableViewCell: SetupSubviewsConstraints {
    func setupSubviewsConstraints() {
        logLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            logLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            logLabel.trailingAnchor.constraint(equalTo: logValue.leadingAnchor, constant: -10),
            logLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -5),
        ])
        
        logValue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logValue.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            logValue.leadingAnchor.constraint(equalTo: logLabel.trailingAnchor, constant: 10),
            logValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            logValue.bottomAnchor.constraint(equalTo: dateValue.topAnchor, constant: -5)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: logLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: logValue.leadingAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        dateValue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateValue.topAnchor.constraint(equalTo: logValue.bottomAnchor, constant: 5),
            dateValue.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            dateValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            dateValue.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    
}
