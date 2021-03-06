# buck_example

Demonstrates how to use the buck package.

## Getting Started

```dart
const BASE_URL = 'http://192.168.1.3:8001';

const CONNECT_API = '/connect';
const LOGIN_API = '/auth/guest/app_login';
const LIST_MESSAGE_API = '/notification/app/list_own';
const READ_MESSAGE_API = '/notification/app/read';
const VERSION_PATH_API = '/admin/app_version/latest';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BUCK";
const TITLE_LABEL = "BUCK";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

Future<void> main() async {
  Buck buck = Buck.getInstance();
  await buck.init(baseUrl: BASE_URL, connectTimeout: 20000, requestTimeout: 40000, menuFree: true);
  buck.settingCommonPath(connectApi: CONNECT_API, loginApi: LOGIN_API, listMessageApi: LIST_MESSAGE_API, readMessageApi: READ_MESSAGE_API, versionApi: VERSION_PATH_API);

  buck.installMenus('Beta', [BundleService(), BundleShopping()]);
  buck.installPianos('Piano Group C', [PianoSetting()]);
  runApp(BasicApp(homeTitle: HOME_TITLE));
}
```