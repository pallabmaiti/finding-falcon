<p align="center">
	<img src="https://sonarcloud.io/api/project_badges/measure?project=pallabmaiti_finding-falcon&metric=coverage">
	<img src="https://sonarcloud.io/api/project_badges/measure?project=pallabmaiti_finding-falcon&metric=alert_status">
</p>

# Finding Falcone!

King Shan has received intelligence that Al Falcone is in hiding in one of these 6 planets - DonLon, Enchai, Jebing, Sapir, Lerbin & Pingasor. However he has limited resources at his disposal & can send his army to only 4 of these planets.

We are going to help King Shan find Al Falcone.

## Running the Application
1.  Open `FindingFalcone.xcodeproj` in Xcode.
2. The application doesn't have any third party. So, no additional step is required. By tapping the play button or `Command + R` should start running the application.

## Modules
The application is divided into three modules: [Select destinations](#select-destinations), [Find Falcone](#find-falcone) & [Networking](#networking).

### Select destinations
In this module, we can choose destinations one after another. Remember next destination can be choosen only after selecting planet & vehicle of current destination.
### Find Falcone
After selecting all the destinations we will move to this module, here we can see if Falcone Queen can be found or not.
### Networking
This module defines how the API calls getting called.
## Testing the Application
From the debug bar, choose the scheme FindingFalconeTests. Run the test cases by `Command + U`(runs all the test cases) or going to individual Test files.
