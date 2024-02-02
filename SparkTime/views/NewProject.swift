
import SwiftUI
extension Color {
	static func random()->Color {
		let r = Double.random(in: 0 ... 1)
		let g = Double.random(in: 0 ... 1)
		let b = Double.random(in: 0 ... 1)
		return Color(red: r, green: g, blue: b)
	}
}


import AVFoundation
@available(iOS 17.0, *)
struct CreateProjectView: View {
	@State private var isCreated = false
	@State private var isError = false
	@EnvironmentObject var dataManager: DataManager
	@State private var isAnimating = false
	@State private var symbolAnimation = false
	@Environment(\.colorScheme) var colorScheme // Get the current color scheme
	
	private let generator = UIImpactFeedbackGenerator(style: .heavy)
	var body: some View {
		
		ZStack() {
			sunview()
			
			VStack {
				Spacer()
				Text("Enter a Project Name").foregroundStyle(Color.white).font(Font.custom("Quicksand", size: 30).bold()).padding(.vertical, 30)
					.frame(maxWidth: .infinity * 0.90, alignment: .center)
				Text("Then click 'Submit' to start your first material list").foregroundStyle(Color.white).font(Font.custom("Quicksand", size: 15))
					.frame(maxWidth: .infinity * 0.90, alignment: .center)
				
				TextField("Enter project name", text: $dataManager.projectName)
					.padding()
					.background(Color.gray.opacity(0.7))
					.foregroundColor(.white)

					.border(Color.black.opacity(0.5), width: 1.0)
					.background(Color("Color 7").opacity(0.8)).background(
						ZStack {
							RoundedRectangle(cornerRadius: 0, style: .circular)
								.fill(Color.gray.opacity(0.01))
							Blur(style: .dark)
						}
					)
				Spacer()
				Button(action: {
					// Call the function here
					createProject(projectName: dataManager.projectName)
					
					// Navigate to the second view
					isCreated = true
				}) {
					Text("Create Project")
						.buttonStyle(PlainButtonStyle())
						.padding()
						.background(Color.green)
						.cornerRadius(8.0)
						.bold()
						.foregroundColor(.white)
				}
				
				NavigationLink(destination: MaterialListView(), isActive: $isCreated) {
					EmptyView()
				}
				.buttonStyle(PlainButtonStyle())

				.background(Color.green)
				.bold()
				.foregroundColor(.white)
				.padding()
				
				
			}
			.padding()
			//			HStack {
			//				if colorScheme == .light {
			//					Image("moonsun")
			//						.symbolRenderingMode(.multicolor)
			//						.font(.title2)
			//						.foregroundStyle(Color.blue.opacity(0.9), Color.blue.opacity(0.9))
			//				} else {
			//					Image("sunmoon")
			//						.symbolRenderingMode(.palette)
			//						.font(.title2)
			//						.foregroundStyle(Color.blue, Color.white)
			//				}
			//			}
			//			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: dataManager.isDarkMode ? .topTrailing : .topLeading)
			//			.padding(.all, 50)
			//			.onTapGesture {
			//				withAnimation(.easeInOut(duration: 3)) {
			//					dataManager.isDarkMode.toggle()
			//				}
			//			}
			//			.onAppear {
			//				symbolAnimation.toggle()
			//			}
			//		}
			//
		}
		.modifier(DarkModeLightModeBackground()) // Apply the modifier here
		
	}
	
	// #if DEBUG
	//	@ObserveInjection var forceRedraw
	// #endif
	//
	
	func createProject(projectName: String) {
		// Define the URL for the API endpoint
		
		generator.impactOccurred()
		let url = URL(string: "https://apps.antflix.net/api/create_project")
		
		// Prepare the request
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		// Create the body of the request
		let bodyData = ["project_name": projectName]
		request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
		
		// Create the URLSession task
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			// Handle the response here
			if let error = error {
				print("Error: \(error)")
				isError = true
			} else if let data = data {
				let str = String(data: data, encoding: .utf8)
				print("Received data:\n\(str ?? "")")
				isCreated = true
			}
		}
		
		// Start the task
		task.resume()
	}
}


//
//@available(iOS 17.0, *)
//struct NewProject_Previews: PreviewProvider {
//	static var previews: some View {
//		NewProject()
//	}
//}
//@available(iOS 17.0, *)
//struct blueGradient: View {
//	@State private var gradientA: [Color] = [.black, .blue]
//	@State private var gradientB: [Color] = [.red, .purple]
//	@State private var quadBracketBox = ""
//	@State private var quadGFCI = ""
//	@State private var quadCutIn = ""
//	@State private var quadSurfaceMounted = ""
//	@State private var quadControlled = ""
//	@State private var firstPlane: Bool = true
//	
//	func setGradient(gradient: [Color]) {
//		if firstPlane {
//			
//			gradientB = gradient
//		}
//		else {
//			gradientA = gradient
//		}
//		firstPlane = !firstPlane
//	}
//	@State private var in6FloorDevice = ""
//	@State private var singlePole277V40AInstahot = "hiugiughiui"
//	@State private var pole208V40AInstahot = ""
//	@State private var singlePole277V30AInstahot = ""
//	@State private var selected = 1
//	@State private var goHome = false
//	var body: some View {
//		
//		ZStack {
//			
//			
//			LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//			
//			LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//				.opacity(self.firstPlane ? 0 : 1)
//			
//			
//				.onChange(of: selected, perform: { value in
//					withAnimation(.spring()) {
//						self.setGradient(gradient: [Color.black, Color.blue])
//					}
//				})
//			
//			
//		}
//		.edgesIgnoringSafeArea(.all)
//		.onAppear()
//		.enableInjection()
//	}
//#if DEBUG
//	@ObserveInjection var forceRedraw
//#endif
//}
//
//@available(iOS 17.0, *)
//struct blueGradient_Previews: PreviewProvider {
//	static var previews: some View {
//		blueGradient()
//	}
//}

@available(iOS 17.0, *)
struct blueGradient: View {
	@EnvironmentObject var dataManager: DataManager
	@State private var gradientA: [Color] = [.black, .blue]
	@State private var gradientB: [Color] = [.blue, .black]
	@State private var quadBracketBox = ""
	@State private var quadGFCI = ""
	@State private var quadCutIn = ""
	@State private var quadSurfaceMounted = ""
	@State private var quadControlled = ""
	@State private var firstPlane: Bool = true
	
	func setGradient(gradient: [Color]) {
		if firstPlane {
			
			gradientB = gradient
		}
		else {
			gradientA = gradient
		}
		firstPlane = !firstPlane
	}
	@State private var in6FloorDevice = ""
	@State private var singlePole277V40AInstahot = ""
	@State private var pole208V40AInstahot = ""
	@State private var singlePole277V30AInstahot = ""
	@State private var selected = 1
	@State private var goHome = false
	var body: some View {
		
		ZStack {
			
			
			LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
			
			LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
				.opacity(self.firstPlane ? 0 : 1)
			
			
			
			
				.onChange(of: selected, perform: { value in
					withAnimation(.spring()) {
						self.setGradient(gradient: [Color.black, dataManager.themeColor])
					}
				})
				.onChange(of: dataManager.themeColor, perform: { _ in // Listen to changes in themeColor
					withAnimation(.spring()) {
						self.setGradient(gradient: [Color.black, dataManager.themeColor]) // Use the updated themeColor
					}
				})
		}
		.edgesIgnoringSafeArea(.all)
		.onAppear {
			// Set actual values after the View has appeared
			gradientA = [.black, dataManager.themeColor]
			gradientB = [dataManager.themeColor, .black]
		}
	}
	
}

import SwiftUI

// SwiftUI wrapper for UIVisualEffectView
struct BlurView: UIViewRepresentable {
	var style: UIBlurEffect.Style
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		UIVisualEffectView(effect: UIBlurEffect(style: style))
	}
	
	func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
		uiView.effect = UIBlurEffect(style: style)
	}
}

struct lightblueGradient: View {
	@EnvironmentObject var dataManager: DataManager
	@State private var gradientA: [Color] = [.gray, .blue]
	@State private var gradientB: [Color] = [.gray, .gray]
	@State private var quadBracketBox = ""
	@State private var quadGFCI = ""
	@State private var quadCutIn = ""
	@State private var quadSurfaceMounted = ""
	@State private var quadControlled = ""
	@State private var firstPlane: Bool = true
	@State private var selected = 1
	
	
	func setGradient(gradient: [Color]) {
		if firstPlane {
			gradientB = gradient
		}
		else {
			gradientA = gradient
		}
		firstPlane = !firstPlane
	}
	
	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
				.opacity(1)
			
			LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
				.opacity(self.firstPlane ? 0 : 1)
			
				.onChange(of: selected, perform: { value in
					withAnimation(.spring()) {
						self.setGradient(gradient: [Color.gray, dataManager.themeColor])
					}
				})
				.onChange(of: dataManager.themeColor, perform: { _ in // Listen to changes in themeColor
					withAnimation(.spring()) {
						self.setGradient(gradient: [Color.gray, dataManager.themeColor]) // Use the updated themeColor
					}
				})
		}
		.edgesIgnoringSafeArea(.all)
		.onAppear {
			// Set actual values after the View has appeared
			gradientA = [.gray, dataManager.themeColor]
			gradientB = [dataManager.themeColor, .gray]
		}
	}
}


@available(iOS 17.0, *)
struct DarkModeLightModeBackground: ViewModifier {
	@EnvironmentObject var dataManager: DataManager
	
	func body(content: Content) -> some View {
		content
			.background(AnyView(Group {
				if dataManager.isDarkMode {
					blueGradient()

				} else {
					lightblueGradient()

				}
			}).transition(.opacity).animation(.easeInOut(duration: 3)))
			.edgesIgnoringSafeArea(.all)
	}
}

//struct blueGradient: View {
//	var body: some View {
//		ZStack {
//			LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//
//			LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//				.opacity(0) // Initially hidden
//		}
//		.edgesIgnoringSafeArea(.all)
//	}
//}

//struct lightblueGradient: View {
//	var body: some View {
//		ZStack {
//			DarkModeLightModeButton()
//
//			LinearGradient(gradient: Gradient(colors: [.gray, .blue]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//
//			LinearGradient(gradient: Gradient(colors: [Color("FF0080"), Color("7FFFD4")]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//				.opacity(0) // Initially hidden
//		}
//
//		.edgesIgnoringSafeArea(.all)
//	}
//}


@available(iOS 17.0, *)
struct sunview: View {
	@EnvironmentObject var dataManager: DataManager // DataManager should have isDarkMode as @Published
	@Environment(\.colorScheme) var colorScheme
	
	
	@State private var rotateDegree: Double = 0
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Image(systemName: dataManager.isDarkMode ? "moon" : "sun.max")
					.padding(10)
					.font(.title)
					
//					.offset(x: 0, y: -geometry.size.width / 4) // Half the screen width for radius
					.rotationEffect(.degrees(rotateDegree))
					.foregroundStyle(dataManager.isDarkMode ? .gray: .yellow)
					
			}
//			.position(x: geometry.size.width / 2, y: geometry.size.height / 7)
			.position(x: geometry.size.width - 40, y: 20 )
//			.onAppear {
//				dataManager.updateDarkMode(colorScheme: colorScheme)
//			}
			.onTapGesture {
				withAnimation(Animation.easeInOut(duration: 0.5)) {
					dataManager.isDarkMode.toggle()
				}
			}
			.onChange(of: colorScheme) { newColorScheme in
				dataManager.updateDarkMode(colorScheme: newColorScheme)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

@available(iOS 17.0, *)
struct sunview_Previews: PreviewProvider {
	
	static var previews: some View {
		NavigationStack {
			sunview()
				.environmentObject(DataManager())
				.navigationBarTitleDisplayMode(.inline)
			
		}
	}
}


@available(iOS 17.0, *)
struct NewProject_Previews: PreviewProvider {
	static var previews: some View {
		lightblueGradient()
			.environmentObject(DataManager())

	}
}
