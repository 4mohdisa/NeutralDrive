//
//  NeutralDriveApp.swift
//  NeutralDrive
//
//  Created by Mohammed Isa on 6/12/2025.
//

import SwiftUI
import FileProvider

@main
struct NeutralDriveApp: App {

    init() {
        // Register the File Provider domain on app launch
        registerFileProviderDomain()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func registerFileProviderDomain() {
        let domain = NSFileProviderDomain(
            identifier: NSFileProviderDomainIdentifier("com.neutralbase.drive"),
            displayName: "Neutral Drive"
        )

        NSFileProviderManager.add(domain) { error in
            if let error = error {
                let nsError = error as NSError
                // Error code -1001 means domain already exists
                if nsError.code == -1001 {
                    print("[NeutralDrive] ✅ Domain already registered")
                } else {
                    print("[NeutralDrive] ❌ Error registering domain: \(error.localizedDescription)")
                    print("[NeutralDrive] Error code: \(nsError.code)")
                }
            } else {
                print("[NeutralDrive] ✅ Successfully registered File Provider domain!")
                print("[NeutralDrive] Check Finder sidebar > Locations for 'Neutral Drive'")
            }
        }
    }
}
