<p align="center">
	<img src="https://sonarcloud.io/api/project_badges/measure?project=pallabmaiti_finding-falcon&metric=coverage">
	<img src="https://sonarcloud.io/api/project_badges/measure?project=pallabmaiti_finding-falcon&metric=alert_status">
</p>

[TOC]

# Finding Falcone!

King Shan has received intelligence that Al Falcone is in hiding in one of these 6 planets - DonLon, Enchai, Jebing, Sapir, Lerbin & Pingasor. However he has limited resources at his disposal & can send his army to only 4 of these planets.

We are going to help King Shan find Al Falcone.

## Running the Application
1.  Open `FindingFalcone.xcodeproj` in Xcode.
2. The application doesn't have any third party. So, no additional step is required. By tapping the play button or `Command + R` should start running the application.



## Modules
The application is divided into three modules: [Select destinations](#select-destinations), [Find Falcone](#find-falcone) & [Networking](#networking).

### Select destinations
In this module, we can choose destinations one after another. Remember next destination can be choosen only after selecting planet & vehicle of current destination. Sequence of the module as follows:
```seq
View->Interator: get (vehicles, planets, token)
Interator->PlanetsAndVehiclesWorker: get (vehicles, planets)
Interator->TokenWorker: get (token)
TokenWorker->NetworkManager: get (token)
NetworkManager->TokenWorker: return (token)
PlanetsAndVehiclesWorker->NetworkManager: get (vehicles, planets)
NetworkManager->PlanetsAndVehiclesWorker: return (vehicles, planets)
TokenWorker->Interator: return (token)
PlanetsAndVehiclesWorker->Interator: return (vehicles, planets)
Interator->Presenter: present (vehicles, planets, token)
Presenter->View: display (vehicles, planets, token)
View->View: show destinations and store token
```
### Find Falcone
After selecting all the destinations we will move to this module, here we can see if Falcone Queen can be found or not. Sequence of the module as follows:
```seq
View->Interator: findFalcone(planetNames, vehcleNames, token)
Interator->FindFalconeWorker: findFalcone(planetNames, vehcleNames, token)
FindFalconeWorker->NetworkManager: findFalcone(planetNames, vehcleNames, token)
NetworkManager->FindFalconeWorker: return response
FindFalconeWorker->Interator: return response
Interator->Presenter: present response
Presenter->View: display sucess or failure
View->View: show sucess or failure
```
### Networking
This module defines how the API calls getting called. Sequence of the module as follows:
```seq
NetworkManager->APIClient: send API
APIClient->APIClient: process dataTask
APIClient->NetworkManager: send data
NetworkManager->ResponseHandler: parse data and convert it to object
ResponseHandler->NetworkManager: send object
```
## Testing the Application
From the debug bar, choose the scheme FindingFalconeTests. Run the test cases by `Command + U`(runs all the test cases) or going to individual Test files.
