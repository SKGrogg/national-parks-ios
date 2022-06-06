***To Run***
Simply download this branch and launch the project in XCODE. 
The project was created on XCODE 13, so ensure you have your IDE up-to-date. 
The app should run on muultiple devices, but was ideally designed to be dispayed in portrait mode on an iPhone.

***App Explanation and Functionality***
This app is meant to provide users information on US National Parks.
The apps pulls its data from a custon JSON file. The JSON does not currently contain information on all US National Parks,
but enough to show how the app is meant to work.

The app has two main tabs: A list of all national parks, and a map that displays their location on a map.
The list can be sorted alphabetically by name, or grouped by the states the parks are locatied within.
The list also has a switch that, when on, sets the app to Light Mode and, when off, sets the app to dark mode.

If a cell from the list is clicked, the user will be brought to a detail page for that park. There, they will see
a photo of the park, and some information regarding its location, size, age, and a placeholder description.
The detail page also has a button that links the user to a map of the hiking trails at that park. 
The user should have the ability to zoom in on the hiking maps for greater detail, but that functionality 
is admittedly a bit buggy at the moment.

The map tab shows where all the loaded parks can be found within the United States. At each location, there is 
a pin with that parks name to let the user know which is which.

***Custom Features***
This app began as a series of class assignments, which led us through the implementation of the List and Detail pages.
For my final project, I implented the tab bar, sorting buttons, dark mode switch, added the MapView, and the segue to the 
hiking maps for each park. My original pitch included added a photo library to each Detail Page to which users could upload,
but I was unable to add that feature in the alloted time.

For more information on these features and their implementation, see this video walkthrough:
https://www.youtube.com/watch?v=W6u0gGJi2Yc

