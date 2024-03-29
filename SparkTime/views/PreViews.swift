//
//  PreView.swift
//  project1
//
//  Created by User on 11/24/23.
//

import Foundation
//import MessageUI
import SwiftUI

@available(iOS 17.0, *)
struct PreViews: View {
    @EnvironmentObject var dataManager: DataManager
	@State private var navigateBack = false
    func generateSMSBody() {
        let sortedOutput = SMSGenerator.sortedFormat(dataManager: dataManager)
        let smsBodyWithDate = SMSGenerator.generateSMSURL(
            sortedOutput: sortedOutput)
        // Append the generated SMS body to the array
		if dataManager.allSMSBodies.last != smsBodyWithDate {
			dataManager.allSMSBodies.append(smsBodyWithDate)
		}
//        dataManager.allSMSBodies.append(smsBodyWithDate)

        // Update savedData to show all stored SMS bodies
        dataManager.allSMSs = dataManager.allSMSBodies.joined(separator: "\n\n")

       }
	func retrieveAndFormatContacts() -> String {
		let savedContacts = dataManager.retrieveSelectedContacts()
		
		// Extract the first phone number of each contact and join them with a comma
		let phoneNumbersString = savedContacts.compactMap { contact -> String? in
			guard let firstPhoneNumber = contact.phoneNumbers.first?.value.stringValue else {
				return nil // Skip contacts without phone numbers
			}
			print("firstphonenumber- \(firstPhoneNumber)")
			return firstPhoneNumber
		}.joined(separator: ", ")
		print("phonenumberString- \(phoneNumbersString)")

		return phoneNumbersString // Return the formatted string
	}

    var body: some View {
        let smsURLString = "sms:/open?addresses=\(retrieveAndFormatContacts())&body=\(dataManager.allSMSs)"

        //      let deviceBg = #colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1)
        return VStack {
			HStack {
				
						Button(action: {
							// Call the function here
							dataManager.clearSMS()
							
							// Navigate to the second view
							navigateBack = true
						}) {
							Image(systemName: "arrow.left")
								.foregroundColor(.white)
								.buttonStyle(PlainButtonStyle())
						}
						
						NavigationLink(destination: EmployeesViews(), isActive: $navigateBack) {
							EmptyView()
						}
					
				
				
				Text("Text Preview").font(Font.custom("Quicksand", size: 30).bold())
					.frame(maxWidth: .infinity * 0.90, alignment: .center)
			}
            .padding()
            .background(dataManager.themeColor)
            .foregroundColor(.white)
            .font(.headline)

            VStack {
                HStack {
                    Text("TIME!!!")
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.green.opacity(0.9))
                        .clipShape(BubbleShape(myMessage: false))
                        .font(.system(size: 14.0))

                    Spacer()
                }.padding(.trailing, 55).padding(.vertical, 10)

                HStack {
                    Spacer()
                    Text("\(dataManager.allSMSs)")
                        .padding()
                        .background(Color(UIColor.systemBlue))
                        .clipShape(BubbleShape(myMessage: true))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading) // Aligning the text to the right
                        .font(.system(size: 14.0))
                }.padding(.leading, 55).padding(.vertical, 10)
                Spacer()
                Divider().frame(height: 1.0).background(
                    Color("Color 6")
                ).padding()
            }.padding(.horizontal, 30)
                .clipShape(RoundedRectangle(cornerRadius: 20)) // Adding rounded corners
                .overlay(
                    RoundedRectangle(cornerRadius: 20) // Overlay for border
                        .stroke(Color("Color 6"), lineWidth: 1)
                        .padding(.horizontal) // Border color and width
                )
            Spacer()
            VStack {
                Button(
                    action: { sendMessage(sms: smsURLString) },
                    label: {
                        Text("Send Message")
                            .font(.title)
                            .foregroundColor(Color.green)
                            .background(Color.clear)
                        Image(systemName: "arrow.up.circle.fill")
                            .background(Color.clear)
                            .foregroundStyle(Color.green)
                            .font(.title)
                    }

                )
                .buttonStyle(PlainButtonStyle()) //
                    .padding()
                NavigationLink(destination: JobsView().navigationBarHidden(true)) {
                    HStack {
                        Text("Add More Time")
                            .foregroundColor(Color.orange)
                            .background(Color.clear)

                        Image(systemName: "hourglass.badge.plus")
                            .foregroundColor(Color.orange)
                            .font(.title)
                            .background(Color.clear)
                    }
                }
                .ignoresSafeArea()
                .buttonStyle(PlainButtonStyle())
//                .navigationBarBackButtonHidden(true)
//                .navigationBarHidden(true)
                .onAppear {
                    generateSMSBody()
                }
				Divider().frame(height: 2.0).background(
					Color("toolbar")
				).padding(.horizontal, 0)
			}
        }
		.toolbar {MyToolbarItems()}
        .background(Color("Color 7"))
		.navigationBarBackButtonHidden(true) // Hides the back button
		.navigationBarHidden(true)
        .onChange(of: dataManager.isDarkMode) { newValue in
            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController?.overrideUserInterfaceStyle = newValue ? .dark : .light
            }
        }

        //            .alert(isPresented: $showAlert) {
        //                Alert(
        //                    title: Text("Enter Phone Number"),
        //                    message: Text("Please enter a phone number"),
        //                    Button: .default(
        //                        Text("Add Phone Number"),
        //                        action: {
        //                            // Toggle popover state
        //                            settingsPopover.toggle()
        //                        }),
        //                    Button: .cancel(Text("Cancel"))
        //
        //                )

        //                            dismissButton: .default(Text("OK"))

    }

}

    func sendMessage(sms: String) {
            guard let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: strURL)
            else { return }

            UIApplication.shared.open(url, options: [:], completionHandler: nil)
		dataManager.stopPersistentAlarm()
//		stopPersistentNotifications()

        }

struct BubbleShape: Shape {
    var myMessage: Bool
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        let bezierPath = UIBezierPath()
        if !myMessage {
            bezierPath.move(to: CGPoint(x: 20, y: height))
            bezierPath.addLine(to: CGPoint(x: width - 15, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - 15), controlPoint1: CGPoint(x: width - 8, y: height), controlPoint2: CGPoint(x: width, y: height - 8))
            bezierPath.addLine(to: CGPoint(x: width, y: 15))
            bezierPath.addCurve(to: CGPoint(x: width - 15, y: 0), controlPoint1: CGPoint(x: width, y: 8), controlPoint2: CGPoint(x: width - 8, y: 0))
            bezierPath.addLine(to: CGPoint(x: 20, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 5, y: 15), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 5, y: 8))
            bezierPath.addLine(to: CGPoint(x: 5, y: height - 10))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 5, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: CGPoint(x: -1, y: height))
            bezierPath.addCurve(to: CGPoint(x: 12, y: height - 4), controlPoint1: CGPoint(x: 4, y: height + 1), controlPoint2: CGPoint(x: 8, y: height - 1))
            bezierPath.addCurve(to: CGPoint(x: 20, y: height), controlPoint1: CGPoint(x: 15, y: height), controlPoint2: CGPoint(x: 20, y: height))
        } else {
            bezierPath.move(to: CGPoint(x: width - 20, y: height))
            bezierPath.addLine(to: CGPoint(x: 15, y: height))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 15), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8))
            bezierPath.addLine(to: CGPoint(x: 0, y: 15))
            bezierPath.addCurve(to: CGPoint(x: 15, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0))
            bezierPath.addLine(to: CGPoint(x: width - 20, y: 0))
            bezierPath.addCurve(to: CGPoint(x: width - 5, y: 15), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 5, y: 8))
            bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 12))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 5, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width + 1, y: height))
            bezierPath.addCurve(to: CGPoint(x: width - 12, y: height - 4), controlPoint1: CGPoint(x: width - 4, y: height + 1), controlPoint2: CGPoint(x: width - 8, y: height - 1))
            bezierPath.addCurve(to: CGPoint(x: width - 20, y: height), controlPoint1: CGPoint(x: width - 15, y: height), controlPoint2: CGPoint(x: width - 20, y: height))
        }
        return Path(bezierPath.cgPath)
    }
}

