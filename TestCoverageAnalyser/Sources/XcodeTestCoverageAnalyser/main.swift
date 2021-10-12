//
//  File.swift
//  
//
//  Created by Daniel Galasko on 2021/08/18.
//

import Foundation

//print("Hello world")

// we need to run xccov via the command line
//xcrun xccov view --report --json Test.xcresult > report.json

let dir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
//print(dir)

let contents = try! FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//print(contents)

let resultFiles = contents.filter({ $0.lastPathComponent.hasSuffix(".json")})//.map({ dir.appending($0) })
//print(resultFiles)

for result in resultFiles {
    guard let data = try? Data(contentsOf: result) else {
        print("FAILED")
        continue
    }
    guard let result = try? JSONDecoder().decode(XCResultJSON.self, from: data) else {
        print("Also Failed")
        continue
    }
    
    //lets sort em
    
    let sortedTargets = result.targets
        .filter({ shouldReadTarget($0) })
        .sorted(by: { $0.lineCoverage > $1.lineCoverage })
    
    let coverageSummedUp = sortedTargets.map(\.lineCoverage).reduce(0, +)
    let overallCoverage = coverageSummedUp / Double(sortedTargets.count)
    
    let totalCoverage = "Total Coverage =  \(round(overallCoverage * 100))%"
    print(totalCoverage)
    print("============")
    for target in sortedTargets {
        print("Coverage for \(target.name) == \(round(target.lineCoverage * 100))%")
    }
    
    do {
        try totalCoverage.write(to: dir.appendingPathComponent("totalCoverage.txt", isDirectory: false), atomically: true, encoding: String.Encoding.utf8)
    } catch {
        print("failed to write total coverage to disk \(error)")
    }
}

func shouldReadTarget(_ target: XCResultJSON.Target) -> Bool {
    let name = target.name
    if (name.hasSuffix(".xctest") ||
            name.hasSuffix(".appex") ||
            name.hasSuffix(".bundle") ||
            name.hasPrefix("Pods_") ||
            name.contains("Demo") ||
            name.contains("Playground") ||
            name.contains("Example.app")) {
        return false
    }
    
    if let firstFile = target.files.first {
        if firstFile.path.contains("/Pods/") || firstFile.path.contains("/SourcePackages/checkouts/"){
            return false
        }
    }
    return true
}
