//
//  AppDelegate.swift
//  MissingArrayContents
//
//  Created by Will Bishop on 29/7/2022.
//

import UIKit
import AppIntents

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}




@available(iOS 16.0, *)
struct MyAppShortcuts: AppShortcutsProvider {
	static var appShortcuts: [AppShortcut] = [
		AppShortcut(intent: DefaultIntent(), phrases: [])
	]
}

@available(iOS 16, *)
struct ItemQuery: EntityPropertyQuery {
	
	static var sortingOptions = SortingOptions {
		SortableBy(\MyEntityType.$itemName)
	}
	
	static var properties = EntityQueryProperties<MyEntityType, (Int) -> Bool> {
		
	}
	
	func entities(matching comparators: [(Int) -> Bool], mode: ComparatorMode, sortedBy: [EntityQuerySort<MyEntityType>], limit: Int?) async throws -> [MyEntityType] {
		return (0 ... 5).map({_ in MyEntityType()})
	}
	
	func entities(for identifiers: [UUID]) async throws -> [MyEntityType] {
		return (0 ... 5).map({_ in MyEntityType()})
	}
	func suggestedEntities() async throws -> [MyEntityType] {
		return (0 ... 5).map({_ in MyEntityType()})
	}
}

struct DefaultIntent: AppIntent {
	static var parameterSummary: some ParameterSummary {
		Summary("Get Items")
	}
	
	static var title: LocalizedStringResource = "Get Items"
	func perform() async throws -> some IntentResult {
		return .result(value: MyEntityType())
	}
}


@available(iOS 16, *)
struct MyEntityType: Identifiable, AppEntity {
	
	let id: UUID
	let name: String
	
	static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Recipe")
	
	@Property(title: "testArray")
	var testArray: [String]
	
	@Property(title: "itemName")
	var itemName: String
	
	init() {
		self.name = String(Int.random(in: 1000000 ..< 2000000))
		self.id = UUID()
		self.itemName = self.name
		
		self.testArray = ["Test"]
		self.$testArray.wrappedValue = ["Other test"]
	}
	
	var displayRepresentation: DisplayRepresentation {
		return DisplayRepresentation(
			title: "\(name)"
		)
	}
	
	static var defaultQuery = ItemQuery()
	
}
extension Sequence {
	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T>,
		ascending: Bool = true
	) -> [Element] {
		sorted { a, b in
			if ascending {
				return a[keyPath: keyPath] < b[keyPath: keyPath]
			} else {
				return a[keyPath: keyPath] > b[keyPath: keyPath]
			}
		}
	}
}

extension Optional where Wrapped == String {
	/// Returns self if not nil, otherwise ""
	var safelyUnwrapped: String {
		return self ?? ""
	}
}
