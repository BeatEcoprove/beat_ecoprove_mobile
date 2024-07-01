# Eco Prove

An application designed to encourage users to improve the circular clothing market. By facilitating the exchange, reuse, and recycling of clothing, this app aims to reduce waste and promote sustainable fashion practices. Users can easily connect to swap, donate, or up-cycle their clothes, contributing to a more sustainable and eco-friendly fashion industry.

## Table of Contents

- [Installation](#installation)
- [Features](#features)

## Installation

### Prerequisites

- [ADB](https://developer.android.com/studio/command-line/adb) (Android Debug Bridge)
- [TaskFile](https://taskfile.dev/) (Tool for building application)
- [Flutter](https://flutter.dev/) (SDK for building the application)

### Steps

1. **Clone the repository:**

```bash
git clone https://github.com/BeatEcoprove/beat_ecoprove_mobile.git ecoprove
```

2. Navigate to the directory `ecoprove`

```bash
cd ecoprove
```

3. Rename de environment file

```bash
mv .env.example .env
```

4. Update environment variables in `.env` file:

```env
BACKEND_URL=http://localhost/api/v1
WEBSOCKETS_URL=ws://localhost/api/v1
API_KEY_CONTRIES=<country.io api key>
BLOB_URL=http://localhost

INSTALL_DEVICE_ID=<DEVICE-ID>
```

5. List connected devices (optional, to verify device connection):

```bash
adb devices -l
```

```bash
List of devices attached
Z8BQB09PLOP            device product:t3jf912 model:KM_AGF12D device:ui1 transport_id:19
```

6. Check the Device Id and put it on `env`

```bash
INSTALL_DEVICE_ID=<DEVICE-ID>
```

7. Build the project:

```bash
task build
```

