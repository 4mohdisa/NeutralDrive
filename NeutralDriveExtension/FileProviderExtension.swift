// STEP 1: File Provider Extension for NeutralBase
// This makes "Neutral Drive" appear in Finder sidebar

import FileProvider
import UniformTypeIdentifiers

class FileProviderExtension: NSObject, NSFileProviderReplicatedExtension {

    // MARK: - Initialization

    required init(domain: NSFileProviderDomain) {
        super.init()
        print("[NeutralDrive] ✅ File Provider Extension initialized")
        print("[NeutralDrive] Domain: \(domain.displayName)")
    }

    func invalidate() {
        print("[NeutralDrive] Extension invalidated")
    }

    // MARK: - Item Retrieval

    func item(for identifier: NSFileProviderItemIdentifier, request: NSFileProviderRequest, completionHandler: @escaping (NSFileProviderItem?, Error?) -> Void) -> Progress {
        print("[NeutralDrive] 📂 Requested item: \(identifier.rawValue)")

        // STEP 1: Only handle root container
        if identifier == .rootContainer {
            let rootItem = RootContainerItem()
            completionHandler(rootItem, nil)
        } else {
            // STEP 2 will implement file items
            let error = NSError(domain: NSFileProviderErrorDomain, code: NSFileProviderError.noSuchItem.rawValue)
            completionHandler(nil, error)
        }

        return Progress()
    }

    // MARK: - Enumerator (Required)

    func enumerator(for containerItemIdentifier: NSFileProviderItemIdentifier, request: NSFileProviderRequest) throws -> NSFileProviderEnumerator {
        print("[NeutralDrive] 📋 Creating enumerator for: \(containerItemIdentifier.rawValue)")
        return FileProviderEnumerator(enumeratedItemIdentifier: containerItemIdentifier)
    }

    // MARK: - Content Fetching (Download)

    func fetchContents(for itemIdentifier: NSFileProviderItemIdentifier, version requestedVersion: NSFileProviderItemVersion?, request: NSFileProviderRequest, completionHandler: @escaping (URL?, NSFileProviderItem?, Error?) -> Void) -> Progress {
        print("[NeutralDrive] ⬇️ Fetch contents: \(itemIdentifier.rawValue)")

        // STEP 1: Not implemented yet
        // STEP 3: Will implement cloud downloads
        // STEP 4: Will implement APFS clones for local files
        let error = NSError(domain: NSFileProviderErrorDomain, code: NSFileProviderError.noSuchItem.rawValue)
        completionHandler(nil, nil, error)

        return Progress()
    }

    // MARK: - Item Creation (Upload)

    func createItem(basedOn itemTemplate: NSFileProviderItem, fields: NSFileProviderItemFields, contents url: URL?, options: NSFileProviderCreateItemOptions = [], request: NSFileProviderRequest, completionHandler: @escaping (NSFileProviderItem?, NSFileProviderItemFields, Bool, Error?) -> Void) -> Progress {
        print("[NeutralDrive] ⬆️ Create item: \(itemTemplate.filename)")

        // STEP 1: Not implemented yet
        let error = NSError(domain: NSFileProviderErrorDomain, code: NSFileProviderError.noSuchItem.rawValue)
        completionHandler(nil, [], false, error)

        return Progress()
    }

    // MARK: - Item Modification (Edit)

    func modifyItem(_ item: NSFileProviderItem, baseVersion version: NSFileProviderItemVersion, changedFields: NSFileProviderItemFields, contents newContents: URL?, options: NSFileProviderModifyItemOptions = [], request: NSFileProviderRequest, completionHandler: @escaping (NSFileProviderItem?, NSFileProviderItemFields, Bool, Error?) -> Void) -> Progress {
        print("[NeutralDrive] ✏️ Modify item: \(item.filename)")

        // STEP 1: Not implemented yet
        // STEP 5: Will implement bi-directional sync
        let error = NSError(domain: NSFileProviderErrorDomain, code: NSFileProviderError.noSuchItem.rawValue)
        completionHandler(nil, [], false, error)

        return Progress()
    }

    // MARK: - Item Deletion

    func deleteItem(identifier: NSFileProviderItemIdentifier, baseVersion version: NSFileProviderItemVersion, options: NSFileProviderDeleteItemOptions = [], request: NSFileProviderRequest, completionHandler: @escaping (Error?) -> Void) -> Progress {
        print("[NeutralDrive] 🗑️ Delete item: \(identifier.rawValue)")

        // STEP 1: Not implemented yet
        let error = NSError(domain: NSFileProviderErrorDomain, code: NSFileProviderError.noSuchItem.rawValue)
        completionHandler(error)

        return Progress()
    }
}

// MARK: - Root Container Item

/// Represents the root "Neutral Drive" folder in Finder
class RootContainerItem: NSObject, NSFileProviderItem {

    var itemIdentifier: NSFileProviderItemIdentifier {
        return .rootContainer
    }

    var parentItemIdentifier: NSFileProviderItemIdentifier {
        return .rootContainer
    }

    var filename: String {
        return "Neutral Drive"
    }

    var contentType: UTType {
        return .folder
    }

    var capabilities: NSFileProviderItemCapabilities {
        // STEP 1: Only allow reading and browsing
        return [.allowsReading, .allowsContentEnumerating]
    }

    var contentModificationDate: Date? {
        return Date()
    }

    var creationDate: Date? {
        return Date()
    }
}
