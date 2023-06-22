//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Mahmoud Mohamed Atrees on 23/05/2023.
//

import Foundation

extension String{
    func capitalizaFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
