# buck_example

Demonstrates how to use the buck package.

## Getting Started

```dart
const BASE_URL = 'http://192.168.0.1:8090/';
const WS_URL = 'ws://192.168.0.1:8091';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BUCK";
const TITLE_LABEL = "BUCK";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

Future<void> main() async {
  Buck buck = Buck.getInstance();
  await buck.init(baseUrl: BASE_URL, wsUrl: WS_URL, menuFree: true);
  buck.installMenus('Alpha', [BundleRest(), BundleDeliver(key: Key('a-deliver'))]);
  buck.installMenus('Beta', [BundleService(), BundleShopping()]);
  buck.installMenus('Gama', [BundleRest(), BundleDeliver(key: Key('c-Deliver')), BundleService(), BundleShopping()]);
  buck.installPianos('Piano Group A', [PianoEarth()]);
  buck.installPianos('Piano Group B', [PianoCollect(), PianoAlbum(), PianoCard(), PianoExpression()]);
  buck.installPianos('Piano Group C', [PianoSetting()]);
  runApp(BasicApp(homeTitle: HOME_TITLE));
}
```