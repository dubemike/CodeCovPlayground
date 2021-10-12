//
//  AppVersionNumber.swift
//  CodeCoverageExample
//
//  Created by Michael Dube on 2021/09/22.
//

import Foundation

/**
 Represents a semantic version number in the form A.B.C since
 thats how we do versioning in Over.

 Its most useful feature is that it implements `Comparable`
 making for easy comparison checks.
 */
struct OverAppVersion: Comparable {
    let version: String

    init(version: String) {
        self.version = version.ensureSemanticallyCorrect()
    }

    func compare(_ version: OverAppVersion) -> ComparisonResult {
        self.version.compare(version.version)
    }
}

func < (lhs: OverAppVersion, rhs: OverAppVersion) -> Bool {
    lhs.version.compare(rhs.version, options: .numeric, range: nil, locale: nil) == .orderedAscending
}

func == (lhs: OverAppVersion, rhs: OverAppVersion) -> Bool {
    lhs.version.compare(rhs.version, options: .numeric, range: nil, locale: nil) == .orderedSame
}

private extension String {

    /// make sure that we always have a semantic version in the form A.B.C
    func ensureSemanticallyCorrect() -> String {
        var comps = self
        // If the version is some kind of prerelease voodoo we strip the info
        // and make it a normal version. Otherwise comparison is such a pain
        let prerelease = components(separatedBy: "-")
        if prerelease.count > 1 {
            comps = prerelease.first!
        }
        let numberOfVersionComponents = comps.components(separatedBy: ".").count
        assert(numberOfVersionComponents < 4, "We dont support versions that are not proper semantic versions.")
        for _ in numberOfVersionComponents ..< 3 {
            comps += ".0"
        }
        return comps
    }
}

extension OverAppVersion: CustomStringConvertible {
    var description: String {
        version
    }
}
