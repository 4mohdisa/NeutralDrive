//
//  FileProviderEnumerator.swift
//  NeutralDriveExtension
//
//  STEP 1: Returns empty list (no files yet)
//  STEP 2: Will return files from Convex database
//

import FileProvider

class FileProviderEnumerator: NSObject, NSFileProviderEnumerator {

    private let enumeratedItemIdentifier: NSFileProviderItemIdentifier
    private let anchor = NSFileProviderSyncAnchor("step1-anchor".data(using: .utf8)!)

    init(enumeratedItemIdentifier: NSFileProviderItemIdentifier) {
        self.enumeratedItemIdentifier = enumeratedItemIdentifier
        super.init()
    }

    func invalidate() {
        print("[NeutralDrive] Enumerator invalidated")
    }

    func enumerateItems(for observer: NSFileProviderEnumerationObserver, startingAt page: NSFileProviderPage) {
        print("[NeutralDrive] 📂 Enumerating items for: \(enumeratedItemIdentifier.rawValue)")

        // STEP 1: Return empty list (no files yet)
        // STEP 2: Will fetch files from Convex database and return them here
        observer.finishEnumerating(upTo: nil)
    }

    func enumerateChanges(for observer: NSFileProviderChangeObserver, from anchor: NSFileProviderSyncAnchor) {
        print("[NeutralDrive] 🔄 Enumerating changes from anchor")

        // STEP 1: No changes to report
        // STEP 2: Will report file additions/modifications/deletions
        observer.finishEnumeratingChanges(upTo: self.anchor, moreComing: false)
    }

    func currentSyncAnchor(completionHandler: @escaping (NSFileProviderSyncAnchor?) -> Void) {
        print("[NeutralDrive] ⚓ Returning current sync anchor")

        // STEP 1: Simple static anchor
        // STEP 2: Will use timestamp-based anchor for sync
        completionHandler(anchor)
    }
}
