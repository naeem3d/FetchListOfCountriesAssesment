//
//  CountryTableViewCell.swift
//  FetchListOfCountriesAssesment
//
//  Created by naeem alabboodi on 8/29/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
static let identitier  = "CountryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryTableViewCell", bundle: nil)
    }
    public func configure(countryName: String, countryCode: String, countryRegion:String, countryCapital:String ) {
        self.countryName.text = countryName
        region.text = countryRegion
        code.text = countryCode
        capital.text = countryCapital
    }

    @IBOutlet var countryName: UILabel!
    @IBOutlet var region: UILabel!
    @IBOutlet var code: UILabel!
    @IBOutlet var capital: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1.0 // Set the width of the border. Adjust as necessary.
            self.layer.borderColor = UIColor.black.cgColor // Set the color of the border. Adjust as necessary.
            self.layer.cornerRadius = 8.0 // Set the corner radius to achieve the rounded effect. Adjust as necessary.
            self.clipsToBounds = true // 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
