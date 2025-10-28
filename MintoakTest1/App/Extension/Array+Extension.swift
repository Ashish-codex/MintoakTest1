//
//  Array+Extension.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 28/10/25.
//

import Foundation


extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
 
extension Array where Element == String {
    func unique() -> [String] {
        var seen = Set<String>()
        return filter { seen.insert($0).inserted }
    }
}

extension String {
    func trimmed() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
}

//extension Array where Element == Hierarchy {
//    // not used above but handy if you want compact filtering helpers
//}

extension Array where Element == String {
    func containsIgnoringWhitespace(_ other: String) -> Bool {
        contains { $0.trimmed().caseInsensitiveCompare(other.trimmed()) == .orderedSame }
    }
}

extension Collection where Element == String {
    func containsIgnoringWhitespace(_ other: String) -> Bool {
        contains { $0.trimmingCharacters(in: .whitespacesAndNewlines).caseInsensitiveCompare(other.trimmingCharacters(in: .whitespacesAndNewlines)) == .orderedSame }
    }
}

extension Dictionary where Key == String, Value == Bool {
    // nothing needed here — used in ViewModel
}
