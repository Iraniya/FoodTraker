//
//  StarRating.swift
//  FoodTracker
//
//  Created by Iraniya Naynesh on 18/03/18.
//  Copyright © 2018 Iraniya Naynesh. All rights reserved.
//

import UIKit

@IBDesignable class StarRating: UIStackView {

    //MARK: Properties
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setUpButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setUpButtons()
        }
    }
    
    @IBInspectable var rating: Int = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    //MARK: Initialization
    
    private var ratingButtons = [UIButton]()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingbuttons array: \(ratingButtons)")
        }
        
        let hintString: String?
        let selectedRating  = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
            hintString = "Tap to reset the rating to zero."
        } else {
            rating = selectedRating
            hintString = nil
        }
        
        //calculate the value string
        
        let valueString: String?
        switch rating {
        case 0:
            valueString = "No value set"
        case 1:
            valueString = "1 star set"
        default:
            valueString = "\(rating) star set"
        }
        
        button.accessibilityHint = hintString
        button.accessibilityValue = valueString
    }
    
    //MARK: Private Methods
    
    private func setUpButtons() {
        
        //clear any exixting buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button image
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            let button = UIButton()
            //add Button constraints
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.accessibilityLabel = "Set \(index + 1) stat rating"
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionState()
    }
    
    private func updateButtonSelectionState() {
        for(index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
