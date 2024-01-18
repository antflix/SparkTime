//
//  OutletsView.swift
//  SparkTime
//
//  Created by User on 1/4/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct SingleGangView: View {
  @EnvironmentObject var dataManager: DataManager
  var body: some View {
    ZStack {
      Spacer()
      VStack {

        Spacer()
        Text("Outlets").foregroundStyle(Color.white).font(
          Font.custom("Quicksand", size: 30).bold()
        )
        .frame(maxWidth: .infinity * 0.90, alignment: .center)

        VStack {
          HStack {
            Spacer()
            Text("Single Gang").foregroundStyle(Color.white).font(.title2).bold().padding(
              .top, 25.0)
            Spacer()
            Image("duplex")
              .padding(.top)
              .padding(.trailing, 40)
              .aspectRatio(contentMode: .fit)
              .symbolRenderingMode(.palette)
              .foregroundStyle(Color.white, Color.blue, Color.black)
              .font(Font.title.weight(.ultraLight))
          }
          Divider().background(Color.green).padding(.horizontal)
          HStack {
            Text("Standard*").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.bracketBoxDuplex).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)
          }

          HStack {
            Text("Controlled").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.controlled).padding(.vertical, 8)  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)

          }.padding(.top)
            .padding(.bottom)
        }.background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding()
        VStack {
          HStack {
            Spacer()
            Text("Two Gang").foregroundStyle(Color.white).font(.title2).bold().padding(.top, 25.0)
            Spacer()
            Image("quad")
              .padding(.top)
              .padding(.trailing, 20)
              .aspectRatio(contentMode: .fit)
              .symbolRenderingMode(.palette)
              .foregroundStyle(Color.white, Color.blue, Color.black)
              .font(Font.title.weight(.ultraLight))
          }
          Divider().background(Color.green)
          HStack {
            Text("Standard*").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.quadBracketBox).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)
          }

          HStack {
            Text("Controlled").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.quadControlled).padding(.vertical, 8)  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)

          }.padding(.top)
            .padding(.bottom)
        }.padding(.horizontal, 20).background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding()
        Spacer()
        Text("*Standard outlets include GFCI and Cut-ins").foregroundStyle(Color.white).padding(
          .vertical
        ).font(.subheadline)
        //                TextField("Quad GFCI", text: $dataManager.quadGFCI).foregroundColor(Color("Color 6"))
        //                TextField("Quad Cut-in", text: $dataManager.quadCutIn).foregroundColor(Color("Color 6"))
        //                TextField("Quad Surface Mounted", text: $dataManager.quadSurfaceMounted).foregroundColor(Color("Color 6"))
      }

    }
  }
}

@available(iOS 17.0, *)
struct BoxTypeView: View {
  @EnvironmentObject var dataManager: DataManager

  var body: some View {
    ZStack {
      Spacer()
      VStack {

        Spacer()

        Text("Outlets Breakdown").foregroundStyle(Color.white).font(
          Font.custom("Quicksand", size: 30).bold()
        )
        .frame(maxWidth: .infinity * 0.90, alignment: .center)
        Text("Out of the \(dataManager.boxTotal) outlets how many of each do you have?").padding(
          .top
        ).foregroundStyle(Color.white).font(Font.custom("Quicksand", size: 12).bold())
          .frame(maxWidth: .infinity * 0.90, alignment: .center)

        VStack {
          HStack {
            Text("Single Gang").padding(.top, 25.0).padding(.horizontal).foregroundStyle(
              Color.white
            ).font(.title2).bold()
            Spacer()
            Image("duplex")
              .padding(.top)
              .padding(.trailing, 40)
              .aspectRatio(contentMode: .fit)
              .symbolRenderingMode(.palette)
              .foregroundStyle(Color.white, Color.blue, Color.black)
              .font(Font.title.weight(.ultraLight))
          }
          Divider().background(Color.green).padding(.horizontal)
          HStack {
            Text("Cut-in").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.cutin).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)
          }

          HStack {
            Text("GFCI").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.gfci).padding(.vertical, 8)  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)
          }

        }.background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)
        VStack {
          HStack {
            Text("Two Gang").padding(.top, 25.0).padding(.horizontal).foregroundStyle(Color.white)
              .font(.title2).bold()
            Spacer()
            Image("quad")
              .padding(.top)
              .padding(.trailing, 20)
              .aspectRatio(contentMode: .fit)
              .symbolRenderingMode(.palette)
              .foregroundStyle(Color.white, Color.blue, Color.black)
              .font(Font.title.weight(.ultraLight))
          }
          Divider().background(Color.green)
          HStack {
            Text("Cut-in").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.quadCutIn).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)
          }

          HStack {
            Text("GFCI").foregroundStyle(Color.white).padding()

            TextField("Quantity", text: $dataManager.quadGFCI).padding(.vertical, 8)  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
              .padding(.trailing)
          }
          .padding(.bottom)

        }.background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding()
        Spacer()

        //                TextField("Quad GFCI", text: $dataManager.quadGFCI).foregroundColor(Color("Color 6"))
        //                TextField("Quad Cut-in", text: $dataManager.quadCutIn).foregroundColor(Color("Color 6"))
        //                TextField("Quad Surface Mounted", text: $dataManager.quadSurfaceMounted).foregroundColor(Color("Color 6"))
      }

    }.onAppear {
      dataManager.calculateTotal()
    }
  }
}

@available(iOS 17.0, *)
struct MiscView: View {
  @EnvironmentObject var dataManager: DataManager
  @State private var selectedOption = "None"

  var body: some View {
    ZStack {
      Spacer()
      VStack {

        Spacer()

        Text("Remaining Wall Devices").foregroundStyle(Color.white).font(
          Font.custom("Quicksand", size: 30).bold()
        )
        .frame(maxWidth: .infinity * 0.90, alignment: .center)
        Text("Out of the \(dataManager.boxTotal) outlets how many of each do you have?").padding(
          .top
        ).foregroundStyle(Color.white).font(Font.custom("Quicksand", size: 12).bold())
          .frame(maxWidth: .infinity * 0.90, alignment: .center)

        VStack {
          Text("Instahots").padding(.top).font(.title2)
          Divider().background(Color.green).padding(.horizontal)

          HStack {
            HStack {
              Text("30A").font(.subheadline).foregroundStyle(Color.white)

              TextField("Quantity", text: $dataManager.singlePole277V30AInstahot).padding()  // Vertical padding
                .foregroundColor(.green.opacity(0.9))  // Text color
                .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
            }
            HStack {
              Text("40A").font(.subheadline).foregroundStyle(Color.white)

              TextField("Quantity", text: $dataManager.singlePole277V40AInstahot).padding()  // Vertical padding
                .foregroundColor(.green.opacity(0.9))  // Text color
                .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
            }

          }.padding(.top, 0).padding(.horizontal)
        }.background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)
        VStack {
          Text("Furniture Feeds").padding(.top).font(.title2)
          Divider().background(Color.green).padding(.horizontal)

          HStack {
            HStack {
              Text("3-wire").font(.subheadline).foregroundStyle(Color.white)

              TextField("Quantity", text: $dataManager.wire3FurnitureFeed).padding()  // Vertical padding
                .foregroundColor(.green.opacity(0.9))  // Text color
                .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
            }
            HStack {
              Text("4-wire").font(.subheadline).foregroundStyle(Color.white)

              TextField("Quantity", text: $dataManager.wire2FurnitureFeed).padding()  // Vertical padding
                .foregroundColor(.green.opacity(0.9))  // Text color
                .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
            }
          }.padding()
        }.background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)
        VStack {
          VStack {
            Text("Misc.").padding(.top).font(.title2)
            Divider().background(Color.green).padding(.horizontal)
          }

          HStack {
            HStack {
              VStack {
                Text("Bracket").font(.subheadline).foregroundStyle(Color.white)
                Text("Data").font(.subheadline).foregroundStyle(Color.white)

              }
              TextField("Quantity", text: $dataManager.bracketBoxData).padding()  // Vertical padding
                .foregroundColor(.green.opacity(0.9))  // Text color
                .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
            }
            VStack {
              Text("Cut-in").font(.subheadline).foregroundStyle(Color.white)
              Text("Data").font(.subheadline).foregroundStyle(Color.white)

            }
            TextField("Quantity", text: $dataManager.cutInData).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
          }.padding(.top, 0).padding(.horizontal)
          HStack {
            VStack {
              Text("Homerun").font(.subheadline).foregroundStyle(Color.white)
              Text("Quantity").font(.subheadline).foregroundStyle(Color.white)

            }
            TextField("Quantity", text: $dataManager.homerunQuantity).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))  // Text color
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline

            VStack {
              Text("Longest").font(.subheadline).foregroundStyle(Color.white)
              Text("HR length").font(.subheadline).foregroundStyle(Color.white)
            }
            TextField("Quantity", text: $dataManager.homerunLength).padding()  // Vertical padding
              .foregroundColor(.green.opacity(0.9))
              .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
          }
          HStack {
            let options = [
              "None", "WIREMOLD- 4FFATC15", "WIREMOLD- #RC4ATC", "WIREMOLD- #RC3ATC",
              "WIREMOLD- #RC9A15TC", "WIREMOLD- #RC7ATC", "WIREMOLD- #WIREMOLD- 6ATC2P",
              "WIREMOLD- #152CHA",
            ]
            Text("Floor Devices")

            Picker("Options", selection: $selectedOption) {
              ForEach(options, id: \.self) { option in
                Text(option).foregroundColor(.white)
              }
            }.pickerStyle(.automatic)
              .foregroundColor(Color.white)
              .background(Color.clear)

            // Display the selected option

          }.padding(.top, 0).padding(.bottom).padding(.horizontal)

        }.background(
          ZStack {
            RoundedRectangle(cornerRadius: 0, style: .circular)
              .fill(Color.gray.opacity(0.01))
            Blur(style: .dark)
          }
        )
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)

        Spacer()

        //                TextField("Quad GFCI", text: $dataManager.quadGFCI).foregroundColor(Color("Color 6"))
        //                TextField("Quad Cut-in", text: $dataManager.quadCutIn).foregroundColor(Color("Color 6"))
        //                TextField("Quad Surface Mounted", text: $dataManager.quadSurfaceMounted).foregroundColor(Color("Color 6"))
      }

    }.onAppear {
      dataManager.calculateTotal()
    }

  }
}

struct SwitchesView: View {
  @EnvironmentObject var dataManager: DataManager
  @State private var isDimmingSwitchActive: Bool = false

  var body: some View {
    ZStack {
      Spacer()
      VStack {
Spacer()
        Text("Switches").foregroundStyle(Color.white).font(
          Font.custom("Quicksand", size: 30).bold()
        )
        .frame(maxWidth: .infinity * 0.90, alignment: .center)

        VStack {
          HStack {
            Spacer()
            Text("Single Gang").foregroundStyle(Color.white).font(.title2).bold().padding(
              .top, 25.0)
            Spacer()
            Image("lightswitch.on.square.fill")
              .padding(.top)
              .padding(.trailing, 40)
              .aspectRatio(contentMode: .fit)
              .symbolRenderingMode(.palette)
              .foregroundStyle(Color.white, Color.blue, Color.black)
              .font(Font.title.weight(.ultraLight))
          }
          Divider().background(Color.green).padding(.horizontal)
			
			HStack(alignment: .top, spacing: 1) {
				VStack {
					Text("")
					Text("Line\nVoltage").font(.subheadline).foregroundStyle(Color.white).padding()
					Text("Low\nVoltage").font(.subheadline).foregroundStyle(Color.white).padding().padding(.top,0)
				
					
				}
				
				VStack {
					Text("Bracket Box").font(.subheadline).padding(.trailing)
					CustomTextField(placeholder: "Quantity", text: $dataManager.lineVoltageSwitch)
					CustomTextField(placeholder: "Quantity", text: $dataManager.lvCat5Switch)
					
				}
				
				VStack {
					Text("Cut-In").font(.subheadline).padding(.trailing)
					CustomTextField(placeholder: "Quantity", text: $dataManager.lineVoltageCutIn)
					CustomTextField(placeholder: "Quantity", text: $dataManager.lvCat5Cutin)
				
				}
				
				VStack {
					Text("").hidden() // Empty cell
					VStack {
						Text("0-10V").font(.caption2)
						Toggle("", isOn: $isDimmingSwitchActive)
							.toggleStyle(CheckboxToggleStyle())
							.font(.subheadline)
							.padding(.bottom, 30)
					}.padding(.horizontal, 2)
					VStack {
						Text("0-10V").font(.caption2)
						Toggle("", isOn: $isDimmingSwitchActive)
							.toggleStyle(CheckboxToggleStyle())
							.font(.subheadline)
							.padding(.bottom, 30)
					}.padding(.horizontal, 2)
					Text("").hidden() // Empty cell
				}.padding(.horizontal, 2)
			}
			.padding(.vertical)

			.frame(maxWidth: .infinity)
          .padding(.bottom)
		} .background(
			.ultraThinMaterial,
			in: RoundedRectangle(cornerRadius: 0, style: .continuous)
			
		).padding(.horizontal)
		  
		  
        Spacer()
		  
		  VStack {
			  HStack {
				  Spacer()
				  Text("2-Gang").foregroundStyle(Color.white).font(.title2).bold().padding(
					.top, 25.0)
				  Spacer()
				  Image("duplex")
					  .padding(.top)
					  .padding(.trailing, 40)
					  .aspectRatio(contentMode: .fit)
					  .symbolRenderingMode(.palette)
					  .foregroundStyle(Color.white, Color.blue, Color.black)
					  .font(Font.title.weight(.ultraLight))
			  }
			  Divider().background(Color.green).padding(.horizontal)
			  
			  HStack(alignment: .top, spacing: 1) {
				  VStack {
					  Text("")
					  Text("Line\nVoltage").font(.subheadline).foregroundStyle(Color.white).padding()
					  Text("Low\nVoltage").font(.subheadline).foregroundStyle(Color.white).padding().padding(.top,0)
					
					  
				  }
				  
				  VStack {
					  Text("Bracket Box").font(.subheadline).padding(.trailing)
					  CustomTextField(placeholder: "Quantity", text: $dataManager.twoGangSwitch)
					  CustomTextField(placeholder: "Quantity", text: $dataManager.lvTwoGangSwitch)
					
				  }
				  
				  VStack {
					  Text("Cut-In").font(.subheadline).padding(.trailing)
					  CustomTextField(placeholder: "Quantity", text: $dataManager.twoGangCutinSwitch)
					  CustomTextField(placeholder: "Quantity", text: $dataManager.lvTwoGangCutinSwitch)
				
				  }
				  
				  VStack {
					  Text("").hidden() // Empty cell
					  VStack {
						  Text("0-10V").font(.caption2)
						  Toggle("", isOn: $isDimmingSwitchActive)
							  .toggleStyle(CheckboxToggleStyle())
							  .font(.subheadline)
							  .padding(.bottom, 30)
					  }.padding(.horizontal, 2)
					  VStack {
						  Text("0-10V").font(.caption2)
						  Toggle("", isOn: $isDimmingSwitchActive)
							  .toggleStyle(CheckboxToggleStyle())
							  .font(.subheadline)
							  .padding(.bottom, 30)
					  }.padding(.horizontal, 2)
					  Text("").hidden() // Empty cell
				  }.padding(.horizontal, 2)
			  }
			  .padding(.vertical)
			  
			  .frame(maxWidth: .infinity)
			  .padding(.bottom)
		  } .background(
			.ultraThinMaterial,
			in: RoundedRectangle(cornerRadius: 8, style: .continuous)
		  ).padding(.horizontal)
		  
		  Spacer()
		
      }

    }
  }

}
struct CheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {

      RoundedRectangle(cornerRadius: 5.0)
        .stroke(lineWidth: 2)
        .frame(width: 25, height: 25)
        .cornerRadius(5.0)
        .overlay {
          Image(systemName: configuration.isOn ? "checkmark" : "")
        }
        .onTapGesture {
          withAnimation(.spring()) {
            configuration.isOn.toggle()
          }
        }

      configuration.label

    }
  }
}
struct CustomTextField: View {
  var placeholder: String
  @Binding var text: String

  var body: some View {
    TextField(placeholder, text: $text)
		  .padding()
      .foregroundColor(.green.opacity(0.9))
      .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))
      .padding(4)
  }
}
@available(iOS 17.0, *)
struct OutletsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SwitchesView()
        .environmentObject(DataManager())
    }
    NavigationStack {
      MaterialFormView()
        .environmentObject(DataManager())
    }
  }
}
