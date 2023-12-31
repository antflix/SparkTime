//
//  StartView.swift
//  SparkTime
//
//  Created by User on 12/31/23.
//

//
//  userInput.swift
//  Material
//
//  Created by User on 12/29/23.


import SwiftUI
import SwiftUI
import SwiftUI

@available(iOS 17.0, *)
struct StartView: View {
	
	var body: some View {
		
		VStack {
			// Header
			Text("SparkList")
				.font(.largeTitle)
				.padding()
			Text("The best apprentice you'll ever hire.")
				.font(.subheadline)
				.padding(.bottom)
			//				AnimatedGradientDivider()
		}
		// Buttons for different options
		VStack {
			NavigationLink(destination: MaterialFormView()) {
				Text("Create Project")
					.foregroundStyle(Color.white)
					.padding(.top, 20)
					.padding(.bottom, 20)
					.frame(maxWidth: .infinity, alignment: .center)
					.background(Color("button1"))
					.cornerRadius(5)
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
				
			}
			
			.padding(.horizontal, 0)
			.padding(.top, 0)
			.padding(.bottom, 5)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			
			Button(action: {
				// Action for View or Edit Existing Project
			}) {
				Text("View")
					.foregroundStyle(Color.white)
					.padding(.top, 20)
					.padding(.bottom, 20)
					.frame(maxWidth: .infinity, alignment: .center)
					.background(Color("button2"))
					.cornerRadius(5)
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
			}
			.padding(.horizontal, 0)
			.padding(.top, 0)
			.padding(.bottom, 5)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			Button(action: {
				// Action for Quick Material List
			}) {
				Text("Quick ")
					.foregroundStyle(Color.white)
					.padding(.top, 20)
					.padding(.bottom, 20)
					.frame(maxWidth: .infinity, alignment: .center)
					.background(Color("button3"))
					.cornerRadius(5)
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
				
			}
			.padding(.horizontal, 0)
			.padding(.top, 0)
			.padding(.bottom, 5)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			
			Button(action: {
				// Action for Quick Material List
			}) {
				Text("Pipe Bending Calculator")
					.foregroundStyle(Color.white)
					.padding(.top, 20)
					.padding(.bottom, 20)
					.frame(maxWidth: .infinity, alignment: .center)
					.background(Color("button1"))
					.cornerRadius(5)
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
				
			}
			.padding(.horizontal, 0)
			.padding(.top, 0)
			.padding(.bottom, 5)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			
			NavigationLink(destination: JobsView()) {
				Text("Time Turner-Inner")
					.foregroundStyle(Color.white)
					.padding(.top, 20)
					.padding(.bottom, 20)
					.frame(maxWidth: .infinity, alignment: .center)
					.background(Color("button2"))
					.cornerRadius(5)
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
				
			}
			.padding(.horizontal, 0)
			.padding(.top, 0)
			.padding(.bottom, 5)
			.frame(maxWidth: .infinity, alignment: .topLeading)
			
			
			
			Spacer()
		}
		.padding()
		.background(Color.black.edgesIgnoringSafeArea(.all))
	}
}


//
//struct AnimatedGradientView: View {
//	var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
//	var body: some View {
//		GeometryReader { geometry in
//			AnimatedGradientModifier(colors: colors, width: geometry.size.width)
//				.frame(height: 4) // Set the height of the divider line
//				.mask(Rectangle())
//		}
//	}
//
//	struct AnimatedGradientModifier: View, AnimatableModifier {
//		var colors: [Color]
//		let width: CGFloat
//		var percent: CGFloat = 0
//
//		var animatableData: CGFloat {
//			get { percent }
//			set { percent = newValue }
//		}
//
//		func body(content: Content) -> some View {
//			content.overlay(
//				LinearGradient(gradient: Gradient(colors: colors), startPoint: UnitPoint(x: percent - 1, y: 0), endPoint: UnitPoint(x: percent, y: 0))
//					.frame(width: width)
//					.offset(x: (percent - 1) * width)
//			)
//			.onAppear {
//				withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
//					self.percent = 1
//				}
//			}
//		}
//	}
//}







@available(iOS 17.0, *)
struct InputFormView_Previews: PreviewProvider {
	static var previews: some View {
		StartView()
	}
}

