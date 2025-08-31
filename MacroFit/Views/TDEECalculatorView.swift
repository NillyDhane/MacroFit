import SwiftUI

struct TDEECalculatorView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingResults = false
    
    var body: some View {
        Form {
            // Personal Information Section
            Section(header: Text("Personal Information")) {
                // Age
                HStack {
                    Label("Age", systemImage: "calendar")
                    Spacer()
                    TextField("Age", value: $viewModel.userProfile.age, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    Text("years")
                        .foregroundColor(.secondary)
                }
                
                // Gender
                HStack {
                    Label("Gender", systemImage: "person.fill")
                    Spacer()
                    Picker("Gender", selection: $viewModel.userProfile.gender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                
                // Weight
                HStack {
                    Label("Weight", systemImage: "scalemass.fill")
                    Spacer()
                    TextField("Weight", value: $viewModel.userProfile.weight, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    Text("kg")
                        .foregroundColor(.secondary)
                }
                
                // Height
                HStack {
                    Label("Height", systemImage: "ruler.fill")
                    Spacer()
                    TextField("Height", value: $viewModel.userProfile.height, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    Text("cm")
                        .foregroundColor(.secondary)
                }
            }
            
            // Activity Level Section
            Section(header: Text("Activity Level")) {
                Picker("Activity Level", selection: $viewModel.userProfile.activityLevel) {
                    ForEach(ActivityLevel.allCases, id: \.self) { level in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(level.rawValue)
                                .font(.body)
                            Text(level.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .tag(level)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            
            // Fitness Goal Section
            Section(header: Text("Fitness Goal")) {
                Picker("Goal", selection: $viewModel.userProfile.goal) {
                    Text("Cutting").tag(FitnessGoal.cutting)
                    Text("Maintenance").tag(FitnessGoal.maintenance)
                    Text("Bulking").tag(FitnessGoal.bulking)
                }
                
                .pickerStyle(SegmentedPickerStyle())
                
                // Goal Description
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                    Text(goalDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Calculate Button
            Button(action: calculateAndShowResults) {
                HStack {
                    Spacer()
                    Image(systemName: "figure.walk.circle.fill")  // Updated symbol here
                    Text("Calculate TDEE")
                        .fontWeight(.semibold)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .background(viewModel.isValidInput ? Color.blue : Color.gray)
                .cornerRadius(10)
            }
            .disabled(!viewModel.isValidInput)
        }
        .navigationTitle("TDEE Calculator")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        )
        .navigationDestination(isPresented: $showingResults) {
            ResultsView()
        }
    }
    
    private var goalDescription: String {
        switch viewModel.userProfile.goal {
        case .cutting:
            return "Lose weight while preserving muscle mass (-500 calories/day)"
        case .maintenance:
            return "Maintain current weight and body composition"
        case .bulking:
            return "Build muscle mass with controlled weight gain (+500 calories/day)"
        }
    }
    
    private func calculateAndShowResults() {
        viewModel.calculateTDEE()
        showingResults = true
    }
}

struct TDEECalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TDEECalculatorView()
                .environmentObject(UserProfileViewModel())
        }
    }
}
