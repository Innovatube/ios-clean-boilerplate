//
//  Data+MimeType.swift
//
//  Created by Dang Thai Son on 3/28/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import MobileCoreServices

let mimeTypeSignatures: [UInt8: String] = [
    0x47: "image/gif",
    0xFF: "image/jpeg",
    0x89: "image/png",
    0x49: "image/tiff",
    0x4D: "image/tiff",
    0x25: "application/pdf"
]
extension Data {
    internal var mimeType: String? {

        let start = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        guard let byte: UInt8 = UnsafeBufferPointer(start: start, count: 1).first else { return nil }
        return mimeTypeSignatures[byte]
    }
}
