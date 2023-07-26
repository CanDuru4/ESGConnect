//
//  AppCheck.swift
//  ESG Connect
//
//  Created by Can Duru on 25.07.2023.
//

//MARK: Import
import Foundation
import FirebaseAppCheck
import FirebaseCore

//MARK: App Check
class MyAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    return AppAttestProvider(app: app)
  }
}
