# MacroFit
IOS SWE University Assignment, MacroFit, personal take on a simple alternative to giants like MFP and MacroFactor

Name: Nilacksha Dhanawardhane
Student Number: s4014943

Github Repo : https://github.com/NillyDhane/MacroFit


References:

Apple Inc. (n.d.) Human Interface Guidelines. Available at: https://developer.apple.com/design/human-interface-guidelines (Accessed: 15 August 2025).
Apple Inc. (n.d.) Managing files and folders in your Xcode project. Available at: https://developer.apple.com/documentation/xcode/managing-files-and-folders-in-your-xcode-project (Accessed: 10 August 2025).
Apple Inc. (n.d.) ScrollView. Available at: https://developer.apple.com/documentation/swiftui/scrollview (Accessed: 5 August 2025).
Apple Inc. (n.d.) SwiftUI App Development Training. Available at: https://developer.apple.com/tutorials/app-dev-training/ (Accessed: 20 August 2025).
Apple Inc. (n.d.) View. Available at: https://developer.apple.com/documentation/swiftui/view (Accessed: 28 July 2025).
Cronometer (n.d.) Cronometer. Available at: https://cronometer.com/ (Accessed: 12 August 2025).
Edamam (n.d.) Edamam. Available at: https://www.edamam.com/ (Accessed: 18 August 2025).
Indently (2021) How to create a Circular Progress Bar in Xcode (SwiftUI / iOS) [Video]. Available at: https://www.youtube.com/watch?v=ikoS43QtLYE&ab_channel=Indently (Accessed: 10 August 2025).
Indently (2022) How to parse & decode JSON data in SwiftUI Tutorial 2022 (Xcode) [Video]. Available at: https://www.youtube.com/watch?v=J06P6AMKo5Q&ab_channel=Indently (Accessed: 15 August 2025).
Lose It! (n.d.) Lose It!. Available at: https://www.loseit.com/ (Accessed: 5 August 2025).
MacroFactor (n.d.) MacroFactor. Available at: https://macrofactorapp.com/macrofactor/ (Accessed: 28 July 2025).
Medscape (n.d.) Mifflin-St Jeor Equation. Available at: https://reference.medscape.com/calculator/846/mifflin-st-jeor-equation (Accessed: 20 August 2025).
MyFitnessPal (n.d.) MyFitnessPal. Available at: https://www.myfitnesspal.com/ (Accessed: 12 August 2025).


Claude Prompt (Used for Recipe Generation) :
“
I need you to generate a JSON representation of a meal database based on a Swift data structure. The structure includes a collection of meals with specific properties and helper functions to filter meals by dietary restrictions and meal type. 
Please generate a JSON file that represents the meals array from the MockData struct. The JSON should include all 12 meals with the following properties for each meal:
name (String)
imageName (String)
calories (Integer)
protein (Integer)
carbs (Integer)
fats (Integer)
mealType (String, e.g., "breakfast", "lunch", "dinner", "vegetarian", "snack", "preworkout", "postworkout")
ingredients (Array of Strings)
instructions (Array of Strings)
prepTime (Integer, in minutes)
restrictions (Array of Strings, e.g., "vegetarian", "vegan", "dairyFree", "glutenFree", "nutFree")

*image unable to be attached due to being in Readme, original images supplied in the final report*

Ensure the JSON maintains the same data as the Swift code, including all 12 meals with their respective values. The output should be a single JSON object with a meals key containing an array of meal objects. Use proper JSON formatting with no trailing commas, and ensure all values match the original Swift data exactly."

