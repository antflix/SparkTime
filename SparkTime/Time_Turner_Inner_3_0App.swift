//
//  Time_Turner_Inner_3_0App.swift
//  Time Turner-Inner 3.0
//
//  Created by User on 12/26/23.
//
import SwiftUI
import UserNotifications
import ContactsUI
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
	let dataManager = DataManager.shared // Change this line
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
			for request in requests {
				print("Activating: \(request.identifier)")
			}
		}
		// Request notification permissions
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
			if granted {
				print("Notification permission granted")
			} else {
				print("Notification permission denied")
			}
		}

		// Configure audio session
		do {
			try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
			try AVAudioSession.sharedInstance().setActive(true)
		} catch {
			print("Failed to configure AVAudioSession: \(error.localizedDescription)")
		}

		// Set the AppDelegate as the delegate for UNUserNotificationCenter
		UNUserNotificationCenter.current().delegate = self

		return true
	}

	// Handle the notification when the app is in the foreground
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		print(" \(notification.request.identifier) triggered")
		if notification.request.identifier == "dailyAlarm" {
			handleDailyAlarmResponse()

		}
		completionHandler([.banner, .sound]) // Customize as needed
	}

	// Handle the user's interaction with the notification
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		print("\(response.notification.request.identifier) notification has been clicked")
		if response.notification.request.identifier == "dailyAlarm" {
			handleDailyAlarmResponse()
		}
		completionHandler()
	}

	// Logic to handle the response to the daily alarm
	func handleDailyAlarmResponse() {
		// Handle the response to the daily alarm
		// Access the shared instance of your DataManager
		// Check if persistent mode is enabled and trigger a persistent alarm
		print("\(dataManager.persistentMode)")
		print("Daily Alarm Triggered")
		// Check if persistent mode is enabled
		if dataManager.persistentMode == true {
			print("persistent mode active and persistent alarm has started ")
			// Trigger the persistent alarm to start immediately and repeat every 60 seconds
			dataManager.persistentAlarm(soundName: "customAlarm-2.mp3")

		}
	}
}

let dataManager = DataManager.shared // Change this line
@available(iOS 17.0, *)
@main
struct Time_Turner_Inner_3_0App: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@State private var showSplash = true // Flag to control splash screen visibility

	var body: some Scene {
		WindowGroup {
			if showSplash {
				LaunchScreen()
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Adjust the duration (e.g., 2 seconds)
							withAnimation {
								showSplash = false // Hide the splash screen after delay
							}
						}
					}
			} else {
				ContentView()
					.environmentObject(dataManager) // Inject the EnvironmentObject
			}
		}
	}
}

#if canImport(HotSwiftUI)
@_exported import HotSwiftUI
#elseif canImport(Inject)
@_exported import Inject
#else
// This code can be found in the Swift package:
// https://github.com/johnno1962/HotSwiftUI

#if DEBUG
import Combine

private var loadInjectionOnce: () = {
        guard objc_getClass("InjectionClient") == nil else {
            return
        }
        #if os(macOS) || targetEnvironment(macCatalyst)
        let bundleName = "macOSInjection.bundle"
        #elseif os(tvOS)
        let bundleName = "tvOSInjection.bundle"
        #elseif targetEnvironment(simulator)
        let bundleName = "iOSInjection.bundle"
        #else
        let bundleName = "maciOSInjection.bundle"
        #endif
        let bundlePath = "/Applications/InjectionIII.app/Contents/Resources/"+bundleName
        guard let bundle = Bundle(path: bundlePath), bundle.load() else {
            return print("""
                ⚠️ Could not load injection bundle from \(bundlePath). \
                Have you downloaded the InjectionIII.app from either \
                https://github.com/johnno1962/InjectionIII/releases \
                or the Mac App Store?
                """)
        }
}()

public let injectionObserver = InjectionObserver()

public class InjectionObserver: ObservableObject {
    @Published var injectionNumber = 0
    var cancellable: AnyCancellable? = nil
    let publisher = PassthroughSubject<Void, Never>()
    init() {
        cancellable = NotificationCenter.default.publisher(for:
            Notification.Name("INJECTION_BUNDLE_NOTIFICATION"))
            .sink { [weak self] change in
            self?.injectionNumber += 1
            self?.publisher.send()
        }
    }
}

extension SwiftUI.View {
    public func eraseToAnyView() -> some SwiftUI.View {
        _ = loadInjectionOnce
        return AnyView(self)
    }
    public func enableInjection() -> some SwiftUI.View {
        return eraseToAnyView()
    }
    public func loadInjection() -> some SwiftUI.View {
        return eraseToAnyView()
    }
    public func onInjection(bumpState: @escaping () -> ()) -> some SwiftUI.View {
        return self
            .onReceive(injectionObserver.publisher, perform: bumpState)
            .eraseToAnyView()
    }
}

@available(iOS 13.0, *)
@propertyWrapper
public struct ObserveInjection: DynamicProperty {
    @ObservedObject private var iO = injectionObserver
    public init() {}
    public private(set) var wrappedValue: Int {
        get {0} set {}
    }
}
#else
extension SwiftUI.View {
    @inline(__always)
    public func eraseToAnyView() -> some SwiftUI.View { return self }
    @inline(__always)
    public func enableInjection() -> some SwiftUI.View { return self }
    @inline(__always)
    public func loadInjection() -> some SwiftUI.View { return self }
    @inline(__always)
    public func onInjection(bumpState: @escaping () -> ()) -> some SwiftUI.View {
        return self
    }
}

@available(iOS 13.0, *)
@propertyWrapper
public struct ObserveInjection {
    public init() {}
    public private(set) var wrappedValue: Int {
        get {0} set {}
    }
}
#endif
#endif
