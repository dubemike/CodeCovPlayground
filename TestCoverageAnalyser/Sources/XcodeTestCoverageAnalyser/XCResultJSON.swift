//
//  XCResultJSON.swift
//  
//
//  Created by Daniel Galasko on 2021/08/18.
//

import Foundation

struct XCResultJSON: Decodable {
    struct Target: Decodable {
        let lineCoverage: Double
        let name: String
        let files: [File]
        
        struct File: Decodable {
            let path: String
        }
    }
    
    let targets: [Target]
}
