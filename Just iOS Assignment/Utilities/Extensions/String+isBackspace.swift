//
//  String+isBackspace.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import Foundation

extension String {
  var isBackspace: Bool {
      if let char = self.cString(using: String.Encoding.utf8) {
          let isBackSpace = strcmp(char, "\\b")
          if isBackSpace == -92 { return true }
      }
      return false
  }
}
