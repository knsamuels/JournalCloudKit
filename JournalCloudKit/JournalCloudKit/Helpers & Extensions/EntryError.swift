//
//  EntryError.swift
//  JournalCloudKit
//
//  Created by Kristin Samuels  on 6/29/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "There was a problem unwrapping."
                
        }
    }
}
