//
//  UIImageView+Ext.swift
//  ZeeMeeTakeHome
//
//  Created by Brett Sarafian on 6/25/23.
//

import Foundation
import UIKit

extension UIImageView {
    private func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }

    func load(urlString: String) {
        if let url = URL(string: urlString) {
            load(url: url)
        }
    }
}
