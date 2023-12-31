//
//  MaterialListView.swift
//  SparkTime
//
//  Created by User on 12/30/23.
//
import Foundation
import SwiftUI
struct MaterialData: Codable {
	var materialName: String
	var quantity: Int
}
// Add other properties as needed
struct Material: Identifiable, Decodable {
	var id: Optional<Int>
	var name: String
	var quantity: Int
	var projectId: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case quantity
		case projectId = "project_id"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decodeIfPresent(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		quantity = try container.decode(Int.self, forKey: .quantity)
		projectId = try container.decode(Int.self, forKey: .projectId)
	}
}

@available(iOS 17.0, *)
struct MaterialFormView: View {
	@State private var isSaved: Bool = false
	@State private var isFetched: Bool = false
	@State private var isError: Bool = false
	
	@State private var bracketBoxDuplex = ""
	@State private var gfci = ""
	@State private var cutin = ""
	@State private var surfaceMounted = ""
	@State private var controlled = ""
	@State private var quadBracketBox = ""
	@State private var quadGFCI = ""
	@State private var quadCutIn = ""
	@State private var quadSurfaceMounted = ""
	@State private var quadControlled = ""
	@State private var wire3FurnitureFeed = ""
	@State private var wire2FurnitureFeed = ""
	@State private var bracketBoxData = ""
	@State private var cutInData = ""
	@State private var lineVoltageDimmingSwitch = ""
	@State private var lineVoltageDimmingCutin = ""
	@State private var lvCat5Switch = ""
	@State private var lvCat5Cutin = ""
	@State private var lineVoltageSwitch = ""
	@State private var lineVoltageCutIn = ""
	@State private var inFloorDevice = ""
	@State private var in6FloorDevice = ""
	@State private var singlePole277V40AInstahot = ""
	@State private var pole208V40AInstahot = ""
	@State private var singlePole277V30AInstahot = ""
	@State private var materials: [Material] = []
	@State private var error: Error?
	@State private var materialID: String = ""
	@State private var material: Material?
	
	var body: some View {
		Form {
			
			Section(header: Text("Single Gang Devices")) {
				TextField("Standard Bracket Box", text: $bracketBoxDuplex)
				TextField("GFCI", text: $gfci)
				TextField("Cut-in", text: $cutin)
				TextField("Surface Mounted", text: $surfaceMounted)
				TextField("Controlled", text: $controlled)
			}
			
			
			Section(header: Text("Single Gang Devices")) {
				
				TextField("Quad Bracket Box", text: $quadBracketBox)
				TextField("Quad GFCI", text: $quadGFCI)
				TextField("Quad Cut-in", text: $quadCutIn)
				TextField("Quad Surface Mounted", text: $quadSurfaceMounted)
				TextField("Quad Controlled", text: $quadControlled)
			}
			
			Section(header: Text("Furniture Feeds")) {
				TextField("3wire Furniture Feed", text: $wire3FurnitureFeed)
				TextField("4wire Furniture Feed", text: $wire2FurnitureFeed)
			}
			
			Section(header: Text("Data Devices")) {
				TextField("Bracket Box Data", text: $bracketBoxData)
				TextField("Cut-in Data", text: $cutInData)
			}
			
			Section(header: Text("Line-Voltage Dimming")) {
				TextField("Line-Voltage Dimming Switch", text: $lineVoltageDimmingSwitch)
				TextField("Line-Voltage Dimming Cutin", text: $lineVoltageDimmingCutin)
			}
			
			Section(header: Text("LV/Cat5")) {
				TextField("LV/Cat5 Switch", text: $lvCat5Switch)
				TextField("LV/Cat5 Cut-in", text: $lvCat5Cutin)
			}
			
			Section(header: Text("Line-Voltage Switch")) {
				TextField("Line-Voltage Switch", text: $lineVoltageSwitch)
				TextField("Line-Voltage Cut-in", text: $lineVoltageCutIn)
			}
			
			Section(header: Text("Floor Devices")) {
				TextField("6in Floor Device", text: $inFloorDevice)
				TextField("4in Floor Device", text: $in6FloorDevice)
			}
			
			Section(header: Text("Instahot")) {
				TextField("Single-Pole 277V 40A Instahot", text: $singlePole277V40AInstahot)
				TextField("2-Pole 208V 40A Instahot", text: $pole208V40AInstahot)
				TextField("Single-Pole 277V 30A Instahot", text: $singlePole277V30AInstahot)
			}
			
			
		}
		Button(isSaved ? "Calculated" : "Calculate Material") {
			Task {
				await submitForm()
				fetchMaterials(projectId: 24) { result in
					switch result {
						case .success(let fetchedMaterials):
							self.materials = fetchedMaterials
							isFetched = true
						case .failure(let error):
							// Handle the error, maybe show an alert or a placeholder text
							print("Error fetching materials: \(error)")
							isError = true
					}
				}
			}
		}.padding()
			.frame(maxWidth: .infinity)
			.background(isError ? .red : .green)
			.foregroundColor(.white)
			.cornerRadius(10)
			.foregroundStyle(isSaved ? .green : .blue)
		//		Button(isError ? "Error" : "Fetch Material List") {
		//			Task {
		//				fetchMaterials(projectId: 24) { result in
		//					switch result {
		//						case .success(let fetchedMaterials):
		//							self.materials = fetchedMaterials
		//							isFetched = true
		//						case .failure(let error):
		//							// Handle the error, maybe show an alert or a placeholder text
		//							print("Error fetching materials: \(error)")
		//							isError = true
		//					}
		//				}
		//			}
		//		}
		//		.padding()
		//		.frame(maxWidth: .infinity)
		//		.background(isError ? .red : .green)
		//		.foregroundColor(.white)
		//		.cornerRadius(10)gsgeeeeeeeeeeeeeeeeeegevvvvvdddccdvvvev eeeeeeeeeeeebbbbbbvbbbbbvv eeeeeeeeeegeeeeee
		ScrollView {
			VStack(alignment: .leading) {
				ForEach(materials) { material in
					VStack(alignment: .leading) {
						Text("\(material.name)- ").foregroundStyle(Color("Color 6").opacity(0.7))
						+
						Text("\(material.quantity)").foregroundStyle(Color.blue.opacity(0.7))
					}
				}
				
			}
			
		}.frame(maxHeight: isFetched ? 300 : 0)
		CreateProjectView()
	}
	
	
	//  Created by User on 12/31/23.
	//
	
	// Function to create a new project
	
	func submitForm() async {
		// Create the JSON data
		let data: [String: String] = [
			
			"Bracket Box Duplex": bracketBoxDuplex,
			"GFCI": gfci,
			"Cut-in": cutin,
			"Surface Mounted": surfaceMounted,
			"Controlled": controlled,
			"Quad Bracket Box": quadBracketBox,
			"Quad GFCI": quadGFCI,
			"Quad Cut-in": quadCutIn,
			"Quad Surface Mounted": quadSurfaceMounted,
			"Quad Controlled": quadControlled,
			"3wire Furniture Feed": wire3FurnitureFeed,
			"4wire Furniture Feed": wire2FurnitureFeed,
			"Bracket Box Data": bracketBoxData,
			"Cut-in Data": cutInData,
			"Line-Voltage Dimming Switch": lineVoltageDimmingSwitch,
			"Line-Voltage Dimming Cut-in": lineVoltageDimmingCutin,
			"LV/Cat5 Switch": lvCat5Switch,
			"LV/Cat5 Cut-in": lvCat5Cutin,
			"Line-Voltage Switch": lineVoltageSwitch,
			"Line-Voltage Cut-in": lineVoltageCutIn,
			"6in Floor Device": inFloorDevice,
			"4in Floor Device": in6FloorDevice,
			"Single-Pole 277V 40A Instahot": singlePole277V40AInstahot,
			"2-Pole 208V 40A Instahot": pole208V40AInstahot,
			"Single-Pole 277V 30A Instahot": singlePole277V30AInstahot
		]
		//		("Surface Mounted", ""),
		//		("Controlled", ""),
		//		("Quad Bracket Box", ""),
		//		("Quad GFCI", ""),
		//		("Quad Cut-in", ""),
		//		("Quad Surface Mounted", ""),
		//		("Quad Controlled", ""),
		//		("3wire Furniture Feed", ""),
		//		("4wire Furniture Feed", ""),
		//		("Bracket Box Data", ""),
		//		("Cut-in Data", ""),
		//		("Line-Voltage Dimming Switch", ""),
		//		("Line-Voltage Dimming Cut-in Cutin", ""),
		//		("LV/Cat5 Switch", ""),
		//		("LV/Cat5 Cutin", ""),
		//		("Line-Voltage Switch", ""),
		//		("Line-Voltage Cut-in", ""),
		//		("6in Floor Device", ""),
		//		("4in Floor Device", ""),
		//		("Single-Pole 277V 40A Instahot", ""),
		//		("2-Pole 208V 40A Instahot", ""),
		var dataDictionary = [String: String]()
		for item in data {
			dataDictionary[item.key] = item.value
		}
		
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: dataDictionary, options: [])
			let jsonString = String(data: jsonData, encoding: .utf8)
			print(jsonString ?? "Invalid JSON")
		} catch {
			print("Error converting to JSON: \(error)")
		}
		await postMaterialData(forProjectID: "25", withData: dataDictionary)
		
	}
	
	func postMaterialData(forProjectID projectID: String, withData data: [String: String]) async {
		
		guard let url = URL(string: "https://apps.antflix.net/api/add_material/25") else { return }
		
		do {
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
			request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
			
			request.httpBody = try JSONEncoder().encode(data)
			
			let (_, response) = try await URLSession.shared.data(for: request)
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				print("Error: Invalid response from server")
				return
			}
			
			// Handle successful response here
			print("Material data saved successfully")
			isSaved = true
		} catch {
			print("Error posting material data: \(error)")
			isError = true
		}
	}
	func fetchMaterials(projectId: Int, completion: @escaping (Result<[Material], Error>) -> Void) {
		let urlString = "https://apps.antflix.net/api/material/24"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				print("Error: \(error.localizedDescription)")
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse,
				  httpResponse.statusCode == 200,
				  let jsonData = data else {
				completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
				print("Error: Invalid response from server")
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let materials = try decoder.decode([Material].self, from: jsonData)
				completion(.success(materials))
				print("Successfully fetched materials")
			} catch {
				completion(.failure(error))
				print("Failed to decode materials: \(error)")
			}
		}.resume()
		
	}
	
}




struct CreateProjectView: View {
	@State private var projectName = ""
	
	var body: some View {
		VStack {
			TextField("Enter project name", text: $projectName)
				.padding()
				.border(Color.gray, width: 0.5)
			
			Button(action: {
				// Call the createProject function when the button is clicked
				createProject(projectName: projectName)
			}) {
				Text("Submitter")
			}
			.padding()
			.background(Color.blue)
			.foregroundColor(.white)
			.cornerRadius(8)
		}
		.padding()
	}
}
func createProject(projectName: String) {
	// Define the URL for the API endpoint
	let url = URL(string: "https://apps.antflix.net/api/create_project")
	
	// Prepare the request
	var request = URLRequest(url: url!)
	request.httpMethod = "POST"
	request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	
	// Create the body of the request
	let bodyData = ["project_name": projectName]
	request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
	
	// Create the URLSession task
	let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
		// Handle the response here
		if let error = error {
			print("Error: \(error)")
		} else if let data = data {
			let str = String(data: data, encoding: .utf8)
			print("Received data:\n\(str ?? "")")
		}
	}
	
	// Start the task
	task.resume()
}


@available(iOS 17.0, *)
struct MaterialFormView_Previews: PreviewProvider {
	static var previews: some View {
		MaterialFormView()
	}
}

