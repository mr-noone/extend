//
//  CountFormatter.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 23.12.2019.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public class CountFormatter: Formatter {
  private typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
  
  public func string(for number: Int) -> String? {
    let numFormatter = NumberFormatter()
    
    let abbreviations:[Abbrevation] = [
      (0, 1, ""),
      (1000.0, 1000.0, "k"),
      (100_000.0, 1_000_000.0, "m"),
      (100_000_000.0, 1_000_000_000.0, "b")
    ]
    let startValue = Double (abs(number))
    let abbreviation: Abbrevation = {
        var prevAbbreviation = abbreviations[0]
        for tmpAbbreviation in abbreviations {
            if (startValue < tmpAbbreviation.threshold) {
                break
            }
            prevAbbreviation = tmpAbbreviation
        }
        return prevAbbreviation
    }()
    
    let value = Double(number) / abbreviation.divisor
    numFormatter.positiveSuffix = abbreviation.suffix
    numFormatter.negativeSuffix = abbreviation.suffix
    numFormatter.allowsFloats = true
    numFormatter.minimumIntegerDigits = 1
    numFormatter.minimumFractionDigits = 0
    numFormatter.maximumFractionDigits = 1
    
    return numFormatter.string(from: NSNumber(floatLiteral: value))
  }
  
  public override func string(for obj: Any?) -> String? {
    if let number = obj as? Int {
      return string(for: number)
    } else {
      return nil
    }
  }
}
