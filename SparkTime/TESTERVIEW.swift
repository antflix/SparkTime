import SwiftUI

struct OutletCalculatorView: View {

  @EnvironmentObject var dataManager: DataManager
  @State private var isSaved: Bool = false
  @State private var isFetched: Bool = false
  @State private var isError: Bool = false

  @State private var materialRequirements: [String: [String: Int]]
  @State private var showingMaterialList = false
  init() {
    if let savedData = UserDefaults.standard.data(forKey: "MaterialRequirements"),
      let decodedData = try? JSONDecoder().decode([String: [String: Int]].self, from: savedData)
    {
      _materialRequirements = State(initialValue: decodedData)
    } else {
      _materialRequirements = State(initialValue: DataManager.defaultMaterialRequirements)
    }
  }

  @State private var calculatedMaterials: [String: Int] = [:]

  @State private var editingMaterialRequirements: Bool = false
  func loadFromUserDefaults() {
    if let savedData = UserDefaults.standard.data(forKey: "MaterialRequirements"),
      let decodedData = try? JSONDecoder().decode([String: [String: Int]].self, from: savedData)
    {
      self.materialRequirements = decodedData
    } else {
      self.materialRequirements = DataManager.defaultMaterialRequirements
    }
  }

  func saveToUserDefaults() {
    if let encoded = try? JSONEncoder().encode(materialRequirements) {
      UserDefaults.standard.set(encoded, forKey: "MaterialRequirements")
    }
  }

  var body: some View {
    VStack {
      //
      Button(editingMaterialRequirements ? "Done Editing" : "Edit Material Requirements") {
        editingMaterialRequirements.toggle()
        saveToUserDefaults()
      }
      .foregroundStyle(Color("BWText"))
      .padding()
      .background(Color.green)

      .sheet(isPresented: $editingMaterialRequirements) {
        EditMaterialRequirementsView(
          materialRequirements: $materialRequirements, allMaterials: dataManager.allMaterials,
          materialKeys: $dataManager.materialKeys, deviceTypesOrder: dataManager.deviceTypesOrder)
      }

      Button(action: {
        self.showingMaterialList = true
      }) {
        Text("Calculate Materials")
      }.background(Color.blue)

        .sheet(isPresented: $showingMaterialList) {
          MaterialsListView(
            materials:
              self.calculateMaterials(quantities: [
                "Standard Bracket Box": dataManager.bracketBoxDuplex,
                "GFCI": dataManager.gfci,
                "Cut-In": dataManager.cutin,
                "Surface Mounted": dataManager.cutin,
                "Controlled": dataManager.controlled,
                "Scaled": dataManager.scaled,
                "Quad Bracket Box": dataManager.quadBracketBox,
                "Quad GFCI": dataManager.quadGFCI,
                "Quad Cut-in": dataManager.quadCutIn,
                "Quad Surface Mounted": dataManager.quadSurfaceMounted,
                "Quad Controlled": dataManager.quadControlled,
                "3wire Furniture Feed": dataManager.wire3FurnitureFeed,
                "4wire Furniture Feed": dataManager.wire2FurnitureFeed,
                "Bracket Box Data": dataManager.bracketBoxData,
                "Cut-in Data": dataManager.cutInData,
                "Line-Voltage Dimming Switch": dataManager.lineVoltageDimmingSwitch,
                "Line-Voltage Dimming Cut-in": dataManager.lineVoltageDimmingCutin,
                "LV/Cat5 Switch": dataManager.lvCat5Switch,
                "LV/Cat5 Cut-in": dataManager.lvCat5Cutin,
                "Line-Voltage Switch": dataManager.lineVoltageSwitch,
                "Line-Voltage Cut-in": dataManager.lineVoltageCutIn,
				"2-Gang Switch": dataManager.twoGangSwitch,
				"2-Gang Cut-In Switch": dataManager.twoGangCutinSwitch,
				"2-Gang LV/Cat5 Switch": dataManager.lvTwoGangSwitch,
				"2-Gang LV/Cat5 Cut-In Switch": dataManager.lvTwoGangCutinSwitch,
                "6in Floor Device": dataManager.inFloorDevice,
                "4in Floor Device": dataManager.in6FloorDevice,
                "Single-Pole 277V 40A Instahot": dataManager.singlePole277V40AInstahot,
                "2-Pole 208V 40A Instahot": dataManager.pole208V40AInstahot,
                "Single-Pole 277V 30A Instahot": dataManager.singlePole277V30AInstahot,
              ]))

        }.padding()
        .foregroundStyle(Color("BWText"))

      //				List(allMaterials, id: \.self) { material in
      //					if let quantity = calculatedMaterials[material] {
      //						if quantity > 0 {
      //							HStack {
      //								Text(material)
      //								Spacer()
      //								Text("\(quantity)")
      //							}
      //						}
      //					}
      //				}

    }.onAppear { loadFromUserDefaults() }
      .padding()
  }
  func calculateMaterials(quantities: [String: String]) -> [String: Int] {
    var totalMaterials: [String: Int] = [:]

    for (deviceType, deviceQuantityString) in quantities {
      if let deviceQuantity = Int(deviceQuantityString) {  // Convert the String to an Int
        for (material, quantity) in materialRequirements[deviceType] ?? [:] {
          totalMaterials[material, default: 0] += quantity * deviceQuantity
        }
      }
    }

    // Add mcTotal to "12/2 LV MC"
    if let mcTotalInt = Int(dataManager.mcTotal) {
      totalMaterials["12/2 LV MC", default: 0] += mcTotalInt
    }

    return totalMaterials
  }
}
struct MaterialsListView: View {
	var materials: [String: Int]
	@EnvironmentObject var dataManager: DataManager  // Assuming you have a dataManager object
	
	var body: some View {
		List(dataManager.allMaterials, id: \.self) { material in
			if let quantity = materials[material], quantity > 0 {
				HStack {
					Text(material)
					Spacer()
					Text("\(quantity)")
				}
			}
		}
	}
}

struct EditMaterialRequirementsView: View {
  @EnvironmentObject var dataManager: DataManager
  @State private var expandedDeviceTypes: [String: Bool] = [:]
  @Binding var materialRequirements: [String: [String: Int]]
  var allMaterials: [String]
  @Binding var materialKeys: [String: [String]]
  // State to handle new material addition
  @State private var showingAddMaterialSheet = false
  @State private var selectedDeviceType: String = ""
  var deviceTypesOrder: [String]
  func saveToUserDefaults() {
    if let encoded = try? JSONEncoder().encode(materialRequirements) {
      UserDefaults.standard.set(encoded, forKey: "MaterialRequirements")
    }
  }

  var body: some View {
    HStack {
      List {
        ForEach(deviceTypesOrder, id: \.self) { deviceType in
          sectionView(for: deviceType)
        }
      }
    }

  }
  private var materialTypes: [String] {
    materialRequirements.keys.sorted()
  }

  @ViewBuilder
  private func sectionView(for outletType: String) -> some View {
    VStack {
      DisclosureGroup(isExpanded: $expandedDeviceTypes[outletType]) {
        ForEach(materialRequirementKeys(for: outletType), id: \.self) { key in
          materialRequirementRow(outletType: outletType, key: key)

        }
        HStack {
          HStack {
            Button(action: {
              selectedDeviceType = outletType
              showingAddMaterialSheet = true
            }) {
              Image(systemName: "plus.circle.fill")
                .foregroundColor(.green)
            }.sheet(isPresented: $showingAddMaterialSheet) {
              AddMaterialView(
                materialRequirements: $materialRequirements,
                materialKeys: $materialKeys,
				allMaterials: dataManager.allMaterials,
                selectedDeviceType: outletType)

            }
            Text("Add\nMaterial").foregroundStyle(Color.blue)
          }.padding().background(Color.red)
          Spacer()

          HStack {
            Button(action: {
              saveToUserDefaults()
              expandedDeviceTypes[outletType] = false
            }) {
              Image("savesymbol")

                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color("BWText"), .green)
            }
            Text("Save\nChanges").foregroundStyle(Color.blue)

          }.padding()

        }
      } label: {
        Text(outletType)
      }
    }
  }
  private func materialRequirementKeys(for outletType: String) -> [String] {
    materialRequirements[outletType]?.keys.sorted() ?? []
  }

  @ViewBuilder
  private func materialRequirementRow(outletType: String, key: String) -> some View {
    HStack {

      Text(key)
        .padding(.leading, 8)  // Padding to separate the text from the minus icon

      Spacer()

      TextField("Quantity", value: binding(for: outletType, key: key), format: .number)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .scaledToFit()

    }.onAppear {

    }
  }

  private func binding(for outletType: String, key: String) -> Binding<Int> {
    Binding(
      get: { self.materialRequirements[outletType]?[key] ?? 0 },
      set: { self.materialRequirements[outletType]?[key] = $0 }
    )
  }
}
struct AddMaterialView: View {
  @Binding var materialRequirements: [String: [String: Int]]
  @Binding var materialKeys: [String: [String]]

  let allMaterials: [String]
  var selectedDeviceType: String

  @State private var selectedMaterial: String = ""
  @State private var materialQuantity: Int = 0
  @Environment(\.dismiss) var dismiss
  func saveToUserDefaults() {
    if let encoded = try? JSONEncoder().encode(materialRequirements) {
      UserDefaults.standard.set(encoded, forKey: "MaterialRequirements")
    }
  }
  private func revertToDefault() {
    // Set materialRequirements to the default values
    materialRequirements =
      DataManager.defaultMaterialRequirements /* Your default materialRequirements here */
    saveToUserDefaults()
  }
  var body: some View {
    NavigationView {
      VStack {
        Text("\(selectedDeviceType)")
        Form {
          Section {
            Picker("Select Material", selection: $selectedMaterial) {
				ForEach(dataManager.allMaterials, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(WheelPickerStyle())
          }

          Section {
            TextField("Quantity", value: $materialQuantity, format: .number)
          }

          Section {
            Button("Add Material") {
              addMaterial(
                to: selectedDeviceType, material: selectedMaterial, quantity: materialQuantity)
              saveToUserDefaults()
              dismiss()

            }
            Button("Revert to Default Settings") {
              revertToDefault()
            }

          }
        }

      }
      .navigationBarTitle("Add Material", displayMode: .inline)
    }
  }

  // When adding a new material, make sure to update both the dictionary and the keys array
  func addMaterial(to deviceType: String, material: String, quantity: Int) {
    print("material\(material) devicetype \(deviceType) quantity \(quantity)")
    if materialRequirements[deviceType]?[material] == nil {
      materialKeys[deviceType]?.append(material)
      saveToUserDefaults()
      print(
        "material- \(material) devicetype- \(deviceType) quantitiy- \(quantity) materialKeys[\(deviceType)]?.append(\(material)"
      )
    }
    materialRequirements[deviceType]?[material] = quantity
    saveToUserDefaults()
    print(
      "material- \(material) devicetype- \(deviceType) quantitiy- \(quantity) materialRequirements[\(deviceType)]?[\(material)] = \(quantity)"
    )

  }
}

struct OutletCalculatorView_Previews: PreviewProvider {
  static var previews: some View {
    OutletCalculatorView()
      .environmentObject(DataManager())

  }
}
//List {
//
//				Section(header: Text("Single Gang Devices").foregroundStyle(dataManager.isDarkMode ? Color.white : Color.black).id(UUID()))  {
//					TextField("Standard Bracket Box", text: $dataManager.bracketBoxDuplex).foregroundColor(Color("Color 6"))
//					TextField("GFCI", text: $dataManager.gfci).foregroundColor(Color("Color 6"))
//					TextField("Cut-In", text: $dataManager.cutin).foregroundColor(Color("Color 6"))
//					TextField("Surface Mounted", text: $dataManager.cutin).foregroundColor(Color("Color 6"))
//					TextField("Controlled", text: $dataManager.controlled).foregroundColor(Color("Color 6"))
//				}.underline()
//				.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Two-Gang Devices").foregroundStyle(Color("BWText")).font(.title2)) {
//					TextField("Quad Bracket Box", text: $dataManager.quadBracketBox).foregroundColor(Color("Color 6"))
//					Text("hello").foregroundStyle(Color("BWText"))
//					TextField("Quad GFCI", text: $dataManager.quadGFCI).foregroundColor(Color("Color 6"))
//					TextField("Quad Cut-in", text: $dataManager.quadCutIn).foregroundColor(Color("Color 6"))
//					TextField("Quad Surface Mounted", text: $dataManager.quadSurfaceMounted).foregroundColor(Color("Color 6"))
//					TextField("Quad Controlled", text: $dataManager.quadControlled).foregroundColor(Color("Color 6"))
//				}.underline()
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Single Gang Devices").foregroundStyle(dataManager.isDarkMode ? Color.white : Color.black).id(UUID())) {
//					TextField("Standard Bracket Box", text: $dataManager.bracketBoxDuplex).foregroundColor(Color("Color 6"))
//					TextField("GFCI", text: $dataManager.gfci).foregroundColor(Color("Color 6"))
//					TextField("Cut-In", text: $dataManager.cutin).foregroundColor(Color("Color 6"))
//					TextField("Surface Mounted", text: $dataManager.cutin).foregroundColor(Color("Color 6"))
//					TextField("Controlled", text: $dataManager.controlled).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Two-Gang Devices").foregroundStyle(Color("BWText")).font(.title2)) {
//					TextField("Quad Bracket Box", text: $dataManager.quadBracketBox).foregroundColor(Color("Color 6"))
//					TextField("Quad GFCI", text: $dataManager.quadGFCI).foregroundColor(Color("Color 6"))
//					TextField("Quad Cut-in", text: $dataManager.quadCutIn).foregroundColor(Color("Color 6"))
//					TextField("Quad Surface Mounted", text: $dataManager.quadSurfaceMounted).foregroundColor(Color("Color 6"))
//					TextField("Quad Controlled", text: $dataManager.quadControlled).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Furniture Feeds").foregroundStyle(Color("Color 1")).font(.title2)) {
//					TextField("3wire Furniture Feed", text: $dataManager.wire3FurnitureFeed).foregroundColor(Color("Color 6"))
//					TextField("4wire Furniture Feed", text: $dataManager.wire2FurnitureFeed).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Data Devices").foregroundStyle(Color("Color 1")).font(.title2)) {
//					TextField("Bracket Box Data", text: $dataManager.bracketBoxData).foregroundColor(Color("Color 6"))
//					TextField("Cut-in Data", text: $dataManager.cutInData).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Line-Voltage Dimming").foregroundStyle(Color("Color 6")).font(.title2)) {
//					TextField("Line-Voltage Dimming Switch", text: $dataManager.lineVoltageDimmingSwitch).foregroundColor(Color("Color 6"))
//					TextField("Line-Voltage Dimming Cut-in", text: $dataManager.lineVoltageDimmingCutin).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("LV/Cat5").foregroundStyle(Color("Color 1")).font(.title2)) {
//					TextField("LV/Cat5 Switch", text: $dataManager.lvCat5Switch).foregroundColor(Color("Color 6"))
//					TextField("LV/Cat5 Cut-in", text: $dataManager.lvCat5Cutin).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Line-Voltage Switch").foregroundStyle(Color("Color 1")).font(.title2)) {
//					TextField("Line-Voltage Switch", text: $dataManager.lineVoltageSwitch).foregroundColor(Color("Color 6"))
//					TextField("Line-Voltage Cut-in", text: $dataManager.lineVoltageCutIn).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Floor Devices").foregroundStyle(Color("Color 1")).font(.title2)) {
//					TextField("6in Floor Device", text: $dataManager.inFloorDevice).foregroundColor(Color("Color 6"))
//					TextField("4in Floor Device", text: $dataManager.in6FloorDevice).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//
//				Section(header: Text("Instahot").foregroundStyle(Color("Color 1")).font(.title2)) {
//					TextField("Single-Pole 277V 40A Instahot", text: $dataManager.singlePole277V40AInstahot).foregroundColor(Color("Color 6"))
//					TextField("Single-Pole 277V 30A Instahot", text: $dataManager.singlePole277V30AInstahot).foregroundColor(Color("Color 6"))
//					TextField("2-Pole 208V 40A Instahot", text: $dataManager.pole208V40AInstahot).foregroundColor(Color("Color 6"))
//				}
//					.frame(alignment: .center)
//			}
//
//			.foregroundColor(.white)
//			.cornerRadius(10)
//			.foregroundStyle(isSaved ? .green : .blue)
//			// Button to toggle editing mode
