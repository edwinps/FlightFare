# FlightFare

The Flight Fare Calculator is an iOS app that aims to find the most economical flight route between two cities based on a given set of flight connections and their prices. This README provides an overview of the solution's architecture, data flow, and key components.

## Problem Statement

The app addresses the problem of finding the cheapest route between two cities from a JSON dataset containing flight connections and prices. The app's goal is to provide users with a convenient way to search for the most cost-effective travel options.

## Architecture

The app follows the Clean Architecture pattern, which separates the project into distinct layers: Data, Domain, and Presentation. This separation promotes modularity, testability, and maintainability.

## Layers:

1. **Data Layer:** Responsible for fetching data from the remote server and converting it into usable models.

2. **Domain Layer:** Contains the core business logic and use cases. It defines the routes finding logic and calculation of the most economical route.

3. **Presentation Layer:** Handles the UI components, user interactions, and displays the calculated routes.

## Data Flow:

The data flows through the app as follows:

1. The **Data Layer** fetches the flight connections data from a remote JSON file using the URLSession framework.

2. The fetched data is then decoded into models using the Swift 'Codable' protocol.

3. The **Domain Layer** uses these models to calculate the most economical flight route between the departure and destination cities.

4. The calculated route is then passed to the **Presentation Layer** for display.

5. The Coordinator Layer manages the navigation between different views, ensuring a clear separation of navigation responsibilities from view controllers.


## Dependency Layer

The app uses the 'FetchConnectionsUseCase' to fetch flight connections data. This use case is implemented using the **Data Layer**, which abstracts the network fetching details. The **Domain Layer** utilizes the 'RouteFinder' to calculate the most economical route.

Additionally, the **Coordinator Layer** has been introduced to handle the navigation flow, enhancing the modularity and maintainability of the app's navigation logic.

By incorporating the Coordinator pattern, the app further enhances its architecture by keeping navigation concerns separate from the presentation logic. This makes it easier to manage complex navigation flows and maintain clean and organized code.
Contributions


