//
//  Card.swift
//  BrainTeaser
//
//  Created by Thiago Costa on 3/30/16.
//  Copyright © 2016 Thiago Costa. All rights reserved.
//

import UIKit

class Card: UIView {
    
    let shapes = ["shape1","shape2","shape3", "shape4",
                  "shape5", "shape6", "shape7", "shape8",
                  "shape9", "shape10", "shape11", "shape12",
                  "shape13", "shape14", "shape15", "shape16"
    ]
    
    var currentShape: String!
    
    @IBOutlet weak var shapeImage: UIImageView!
    @IBOutlet var resutlsLbl: UILabel!
    @IBOutlet var correctLbl: UILabel!
    @IBOutlet var incorrectLbl: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        selectShape()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 12.0
        self.layer.shadowOffset = CGSizeMake(-1.0, 5.0)
        self.layer.shadowColor = UIColor(red: 167.0/255.0, green: 167.0/255.0, blue: 167.0/255.0, alpha: 1.0).CGColor
        self.setNeedsLayout()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(16))]
        shapeImage.image = UIImage(named: currentShape)
    }
    
    
}









