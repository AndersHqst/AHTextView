//  AHTextView.swift
//  Created by Anders Høst Kjærgaard on 09/08/2015.

import Foundation
import UIKit

class AHTextView: UITextView {
    
    // Placeholder text in the UITextView
    var placeholder: String?
    
    private var placeholderLabel: UILabel!
    
    // Animation duration for showing and hiding the placeholderLabel
    private static let duration = 0.25
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.addObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addObservers()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func addObservers() {
        
        // Guard to not add observers more than once
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        // Observe UITextView text changes to update the placeholder accordingly
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updatePlaceholder:", name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Add a label as subview for the placeholder text
        if self.placeholderLabel == nil {
            let frame = CGRectMake(self.textContainer.lineFragmentPadding, self.textContainerInset.top, self.frame.size.width, 0);
            placeholderLabel = UILabel(frame: frame)
            placeholderLabel.alpha = 0
            placeholderLabel.numberOfLines = 0;
            placeholderLabel.lineBreakMode = self.textContainer.lineBreakMode
            placeholderLabel.font = self.font;
            placeholderLabel.textColor = UIColor.lightGrayColor()
            placeholderLabel.backgroundColor = UIColor.clearColor()
            self.addSubview(placeholderLabel)
        }
    }
    
    // Helper function to animate the alpha of a view
    let animateAlpha = {
        (alpha: CGFloat, view: UIView) -> Void in
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                view.alpha = alpha
            }, completion: nil)
    }
    
    // Show or hide the placeholder label as needed
    func updatePlaceholder(notification: NSNotification?) {
        if self.placeholder?.characters.count == 0 { return }
        
        if self.text.characters.count == 0 && self.placeholderLabel?.alpha == 0 {
            self.animateAlpha(1.0, self.placeholderLabel)
        } else if self.text.characters.count > 0 && self.placeholderLabel?.alpha == 1 {
            self.animateAlpha(0.0, self.placeholderLabel)
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        self.placeholderLabel.text = self.placeholder
        self.updatePlaceholder(nil)
        self.placeholderLabel.sizeToFit()
    }
}

