//
//  main.swift
//  zerocheck
//
//  Created by Carl Sandrock on 2020-08-15.
//  Copyright © 2020 Carl Sandrock. All rights reserved.
//

import Foundation

if (CommandLine.arguments.count != 2) {
    print("Invalid arguments")
    exit(2)
}

let filename = CommandLine.arguments[1]

let data = try Data(contentsOf: URL(fileURLWithPath: filename))

for byte in data {
    if byte != 0 {
        exit(1)
    }
}

print(filename)
