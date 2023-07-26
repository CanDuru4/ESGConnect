//
//  InfoTableViewCell.swift
//  ESG Connect
//
//  Created by Can Duru on 25.07.2023.
//

import UIKit


class InfoTableViewCell: UITableViewCell {

//MARK: Set Up
    static let identifer = "InfoTableViewCell"
    
    var dataStructure: Info!
    var titleLabel:UILabel!
    var detailLabel_employee_education:UILabel!
    var detailLabel_location: UILabel!
    var detailLabel_social: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    

//MARK: Select Cell Function
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
//MARK: Load
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InfoTableViewCell.identifer)
        configureViews()

    }
        
//MARK: Set Contents
    func configureViews(){
        
        //MARK: Name Title
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .systemGray
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(titleLabel)
        
        
        //MARK: Employee / Education Subtitle
        detailLabel_employee_education = UILabel()
        detailLabel_employee_education.numberOfLines = -1
        detailLabel_employee_education.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailLabel_employee_education)
        
        //MARK: Location Subtitle
        detailLabel_location = UILabel()
        detailLabel_location.numberOfLines = -1
        detailLabel_location.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailLabel_location)
        
        //MARK: Social Subtitle
        detailLabel_social = UILabel()
        detailLabel_social.numberOfLines = -1
        detailLabel_social.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailLabel_social)

        

    //MARK: Constraints
        NSLayoutConstraint.activate([
        
        
            //MARK: Title Constraints
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            //MARK: Location Constraints
            detailLabel_location.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            detailLabel_location.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            detailLabel_location.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            //MARK: Employee / Education Constraints
            detailLabel_employee_education.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            detailLabel_employee_education.topAnchor.constraint(equalTo: detailLabel_location.bottomAnchor, constant: 5),
            
            //MARK: Social Constraints
            detailLabel_social.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            detailLabel_social.topAnchor.constraint(equalTo: detailLabel_employee_education.bottomAnchor, constant: 5),
            detailLabel_social.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
