//
//  ImageUnification.swift
//  RemoteDataExample
//
//  Created by Jakub Darowski on 11/02/2023.
//

import SwiftUI
#if os(iOS) || os(watchOS) || os(tvOS)
    import UIKit
    typealias RDImage = UIImage
#elseif os(macOS)
    import AppKit
    typealias RDImage = NSImage
#endif

extension Image {
    init(image: RDImage) {
    #if os(iOS) || os(watchOS) || os(tvOS)
        self.init(uiImage: image)
    #elseif os(macOS)
        self.init(nsImage: image)
    #endif
    }
}
