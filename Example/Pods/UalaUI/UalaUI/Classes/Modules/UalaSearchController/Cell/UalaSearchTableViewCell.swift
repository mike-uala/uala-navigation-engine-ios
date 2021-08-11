//
//  UalaSearchTableViewCell.swift
//  UalaUI
//
//  Created by Ariel Congestri on 07/04/2020.
//

import UIKit

class UalaSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!

    func configureName(_ name: String) {
        self.name.text = name
    }
}
