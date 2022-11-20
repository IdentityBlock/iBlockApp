<h1 style="text-align: center">iBlock Mobile Application</h1> 

Source code for the mobile application of the `iBlock` person verification digital platform.  

### Objective
Provide a user-friendly interface to interact with the platform.

### Directory Structure
Since project uses Flutter framework directories are organized according to it. The development is completely inside `/lib` directory.
<br/>
Overview of files and directories in `/lib`
* `main.dart` - Handling theming, routing of the application.
* `config.dart` - Configurations for the application.
* `/bloc` - Contains all business logics for the application. The project is using [flutter_bloc](https://pub.dev/packages/flutter_bloc) library for state management.
  * `/initialize` - contains all business logic, states, events related to initializing the app.
  * `/signup` - contains all business logic, states, events used for signup process (including the recovery).
  * `/settings` - contains all business logic, states, events for handle settings of the application.
  * `/verify` - contains all business logic, states, events for handle verify process.
* `/pages` - Contains files for render the screens in the app.
* `/widgets` - Contains all supporting widgets created.
* `/services` - Contains all services created to support the application activities.

### Configurations
App can be configured to be used in any ethereum based testnet. To configure edit the `lib/config.dart` file.
Following is a sample configuration to link with local ganache server
```dart
static const String rpcUrl = "http://localhost:7547"; // local ganache server address
static const String wsUrl = "ws://localhost:7547";
static const int chainId = 5777; // chainID of the ganache blockchain
```
Application has a backend with few REST API end points. [link](https://github.com/IdentityBlock/iBlock-App-Backend).
```dart
static const String backendUrl = "http://localhost:3000"; // address of the backend server
```

Since backend REST end points are protected with an `APIKEY` need to create a `secrets.dart` within the `lib/` directory.
There specify the `APIKEY` used by the backend as follows.

```dart
const String APIKEY = "<APIKEY>";
```

### Initial Design
* Figma Prototype : https://bit.ly/3xdMi33

### Built with :
![Flutter](https://img.shields.io/badge/-Flutter-white?style=for-the-badge&labelColor=000000&logo=flutter)


