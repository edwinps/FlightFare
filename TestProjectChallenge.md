# FlightFare
Write an app that helps users select the most convenient route between our destinations.
 
Download and parse information from: https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/connections.json - The JSON contains a list of flight connections with the relative price and position.
 
The user should be able to select any departure city and any destination city available (even if a direct connection between the two cities is not available)
 
The purpose of this app is to find the cheapest route between the two cities that the user select and to show the total price in a label in the same page
 
Use coordinates available in the JSON to show the cheapest selected route on a map
 
BONUS: To select the cities use a text field with autocomplete (from the list of the available cities you get from the JSON)
 
 
Instructions:
 
Write the app thinking about code reusability and SOLID principles - Don’t pay too much attention to UI/UX, use standard UI elements instead
Code in the latest version of Swift
Use iOS SDK version of your choice
Don’t use any 3rd party tools/frameworks but, you can use any Apple provided libraries.
Return Xcode project, zipped or uploaded to your Github and few words about your code.
Do Test-driven Development and write meaningful unit tests
Please note that we have different datasets for testing and we expect that your app still works with different cities and/or prices
