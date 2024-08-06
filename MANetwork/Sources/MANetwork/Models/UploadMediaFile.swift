//
//  UploadMediaFile.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

public
struct UploadMediaFile {
  let key: String
  let filename: String
  let data: Data
  let mimeType: String
  init(data: Data, forKey key: String) {
    self.key = key
    self.mimeType = "image/jpeg"
    self.filename = "imagefile.jpg"
    self.data = data
  }
}
