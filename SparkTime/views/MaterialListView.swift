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
	@EnvironmentObject var dataManager: DataManager
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
		ZStack {
			
			VStack {
				Form {
					Section(header: Text("Single Gang Devices").foregroundStyle(dataManager.isDarkMode ? Color.black : Color.white))  {
						HStack {
							
							TextField("Enter Quantity", text: $bracketBoxDuplex)
							
								.foregroundColor(Color("Color 6"))
							
						}
						TextField("GFCI", text: $gfci).foregroundColor(Color("Color 6"))
						TextField("Cut-in", text: $cutin).foregroundColor(Color("Color 6"))
						TextField("Surface Mounted", text: $surfaceMounted).foregroundColor(Color("Color 6"))
						TextField("Controlled", text: $controlled).foregroundColor(Color("Color 6")).background(Color.white.opacity(0.0001))
						
					}
					.padding(.vertical, 8) // Vertical padding
					.foregroundColor(.green.opacity(0.9)) // Text color
					.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue)) // Underline
					.padding(.trailing).scrollContentBackground(.hidden)
					
					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Single Gang Devices").foregroundStyle(dataManager.isDarkMode ? Color.white : Color.black).id(UUID()))  {
						TextField("Standard Bracket Box", text: $dataManager.bracketBoxDuplex).foregroundColor(Color("Color 6"))
						TextField("GFCI", text: $gfci).foregroundColor(Color("Color 6"))
						TextField("Cut-in", text: $cutin).foregroundColor(Color("Color 6"))
						TextField("Surface Mounted", text: $surfaceMounted).foregroundColor(Color("Color 6"))
						TextField("Controlled", text: $controlled).foregroundColor(Color("Color 6")).background(Color.white.opacity(0.0001))
					}/*.background(Color.white.opacity(0.0001))*/
					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Two-Gang Devices").foregroundStyle(Color("BWText")).font(.title2)) {
						TextField("Quad Bracket Box", text: $quadBracketBox).foregroundColor(Color("BWText"))
						
						TextField("Quad GFCI", text: $quadGFCI).foregroundColor(Color("Color 6"))
						TextField("Quad Cut-in", text: $quadCutIn).foregroundColor(Color("Color 6"))
						TextField("Quad Surface Mounted", text: $quadSurfaceMounted).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Furniture Feeds").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("3wire Furniture Feed", text: $wire3FurnitureFeed).foregroundColor(Color("Color 6"))
						TextField("4wire Furniture Feed", text: $wire2FurnitureFeed).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Data Devices").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("Bracket Box Data", text: $bracketBoxData).foregroundColor(Color("Color 6"))
						TextField("Cut-in Data", text: $cutInData).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Line-Voltage Dimming").foregroundStyle(Color("Color 6")).font(.title2)) {
						TextField("Line-Voltage Dimming Switch", text: $lineVoltageDimmingSwitch).foregroundColor(Color("Color 6"))
						TextField("Line-Voltage Dimming Cutin", text: $lineVoltageDimmingCutin).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("LV/Cat5").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("LV/Cat5 Switch", text: $lvCat5Switch).foregroundColor(Color("Color 6"))
						TextField("LV/Cat5 Cut-in", text: $lvCat5Cutin).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Line-Voltage Switch").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("Line-Voltage Switch", text: $lineVoltageSwitch).foregroundColor(Color("Color 6"))
						TextField("Line-Voltage Cut-in", text: $lineVoltageCutIn).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Floor Devices").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("6in Floor Device", text: $inFloorDevice).foregroundColor(Color("Color 6"))
						TextField("4in Floor Device", text: $in6FloorDevice).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Instahot").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("Single-Pole 277V 40A Instahot", text: $singlePole277V40AInstahot).foregroundColor(Color("Color 6"))
						TextField("2-Pole 208V 40A Instahot", text: $pole208V40AInstahot).foregroundColor(Color("Color 6"))
						TextField("Single-Pole 277V 30A Instahot", text: $singlePole277V30AInstahot).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: .center)
					
//					Button(isSaved ? "Calculated" : "Calculate Material") {
//						Task {
//							await submitForm()
//							fetchMaterials(projectName: dataManager.projectName) { result in
//								switch result {
//									case let .success(fetchedMaterials):
//										self.materials = fetchedMaterials
//										isFetched = true
//									case let .failure(error):
//										// Handle the error, maybe show an alert or a placeholder text
//										print("Error fetching materials: \(error)")
//										isError = true
//								}
//							}
//						}
//					}.padding()
						.frame(maxWidth: .infinity)
					//					.background(isError ? .red : .green)
						.foregroundColor(.white)
						.cornerRadius(10)
						.foregroundStyle(isSaved ? .green : .blue)
				}.scrollContentBackground(.hidden)
					.padding(.top, 50)//
				ScrollView {
					VStack(alignment: .leading) {
						ForEach(materials) { material in
							VStack(alignment: .leading) {
								Text("\(material.name)- ").foregroundStyle(Color.black)
								+
								Text("\(material.quantity)").foregroundStyle(Color.yellow.opacity(0.7))
							}
						}
					}
					
				}.frame(maxHeight: isFetched ? 300 : 0)
			}.padding(.top, 70)
			
			
		}
    }


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
            "Single-Pole 277V 30A Instahot": singlePole277V30AInstahot,
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
		await postMaterialData(projectName: dataManager.projectName, withData: dataDictionary)
    }

	func postMaterialData(projectName: String, withData data: [String: String]) async {
		guard let url = URL(string: "https://apps.antflix.net/api/add_material/\(dataManager.projectName)") else { return }

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

	func fetchMaterials(projectName: String, completion: @escaping (Result<[Material], Error>) -> Void) {
		let urlString = "https://apps.antflix.net/api/material/\(dataManager.projectName)"
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


@available(iOS 17.0, *)
struct MaterialListView: View {
//	@State private var gradientA: [Color] = [.black, .blue]
//	@State private var gradientB: [Color] = [.red, .purple]
//	
	@State private var firstPlane: Bool = true
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
//	
	@State private var selected = 0
	@State private var goHome = false
	var body: some View {
		
		ZStack {
			
//			sunview()
//			LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//			
//			LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
//				.opacity(self.firstPlane ? 0 : 0)
			
			TabView(selection: $selected) {
				VStack {
					SingleGangView()
					
				}.tag(0)
				VStack {
					BoxTypeView()
					
				}.tag(1)
				
				VStack {
					SwitchesView()
					
				}.tag(2)
				VStack {
					
					MiscView()
				}.tag(3)
				VStack {
					OutletCalculatorView()
					
				}.tag(4)
			}
			.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
			.tabViewStyle(PageTabViewStyle())
//			.onChange(of: selected, perform: { value in
//				withAnimation(.spring()) {
//					self.setGradient(gradient: [Color.black, Color.blue])
//				}
//			})
			.navigationBarTitleDisplayMode(.inline)
			
			.navigationTitle(dataManager.projectName)
			.toolbar {
				ToolbarItem() {
					sunview().padding(30)
				}
			}
		}.modifier(DarkModeLightModeBackground())
		.edgesIgnoringSafeArea(.all)
		.onAppear()
		
		
	}

}
@available(iOS 17.0, *)
struct MaterialFormView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			
			MaterialListView()
				.environmentObject(DataManager())
		}
		NavigationStack {
			MaterialFormView()
				.environmentObject(DataManager())
			
		}
		NavigationStack {
			MiscView()
				.environmentObject(DataManager())
			
		}

    }
}

