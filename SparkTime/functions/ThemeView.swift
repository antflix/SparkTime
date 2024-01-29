//
//  ThemeView.swift
//  SparkTime
//
//  Created by Anthony on 1/28/24.
//
//.variableColor.cumulative.dimInactiveLayers.reversing
import SwiftUI
import Foundation
@available(iOS 17.0, *)
struct ThemeView: View {
	@EnvironmentObject var dataManager:DataManager
	
	let colors: [Color] = [.blue, .green, .orange, .pink, .purple, .black, .gray]
	
	var body: some View {
		VStack { // Change VStack alignment to center
			sunview()
			ScrollView {
				HStack {
					
					Spacer()
					Text("Select a theme color")
						.padding(.bottom)
						.fontWeight(.bold)
					Spacer()
					
				}
				ForEach(colors, id: \.self) { color in
					HStack {
						Circle()
							.fill(color)
							.frame(width: 24, height: 24)
						Text(color.description.capitalized)
							.padding()
					}
					.onTapGesture {
						dataManager.themeColor = color
					}
				}
			}
		}
//		.toolbar {
//			ToolbarItem() {
//				sunview().padding(30)
//			}
//		}
		.padding(.top, 1)
		.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
		.modifier(DarkModeLightModeBackground())
		.edgesIgnoringSafeArea(.all)
	}
}

@available(iOS 17.0, *)
struct themeView: PreviewProvider {
	static var previews: some View {
		
			ThemeView()
				.environmentObject(DataManager())
			
	
	}
}
