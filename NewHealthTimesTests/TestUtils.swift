//
//  TestUtils.swift
//  NewHealthTimesTests
//
//  Created by Cary Zhou on 4/27/21.
//

import XCTest

extension XCTestCase {
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }
}
