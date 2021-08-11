//
//  TapeableTextView.swift
//  UalaUI
//
//  Created by Ariel Congestri on 12/12/2019.
//

import Foundation

public class TapeableTextView: UITextView {

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        guard let pos = closestPosition(to: point) else { return false }

        guard let range = tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: .layout(.left)) else { return false }

        let startIndex = offset(from: beginningOfDocument, to: range.start)

        return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
    }
}
