# NearDrop Plus

**NearDrop Plus** is a partial implementation of [Google's Nearby Share](https://blog.google/products/android/nearby-share/) for macOS

[Protocol documentation](/PROTOCOL.md) is available separately.

The app lives in your menu bar and saves files to your downloads folder. It's that simple, really.

## Difference between original NearDrop and my implementation

Since author does not want these changes, I will keep them in this repo.

- Implemented settings page.
![Settings window](/images/settings.png)
- You can change computer name
- You can change notification type for incoming file requests. Instead of MacOS notification you can switch to Alert dialog style
- Launch at Login
- Files can be accepted and downloaded into Downloads folder automatically
- Safe files can be opened automatically. Only Images and Plain Text files can be opened
- Text and URL can be received. Both will be opened in separate window where user can copy, open in browser or save text as a file

## Limitations

- **Receive only**. For now. I haven't yet figured out how to make Android turn on the MDNS service and/or show the "a device nearby is sharing" notification.
- **Wi-Fi LAN only**. Your Android device and your Mac need to be on the same network for this app to work. Google's implementation supports multiple mediums, including Wi-Fi Direct, Wi-Fi hotspot, Bluetooth, some kind of 5G peer-to-peer connection, and even a WebRTC-based protocol that goes over the internet through Google servers. Wi-Fi direct isn't supported on macOS (Apple has their own, incompatible, AWDL thing, used in AirDrop). Bluetooth needs further reverse engineering.
- **Visible to everyone on your network at all times** while the app is running. Limited visibility (contacts etc) requires talking to Google servers, and becoming temporarily visible requires listening for whatever triggers the "device nearby is sharing" notification.

## Installation

Download .zip file from release page. Extract it and copy NerDropPlus.app to Applications folder.

## Credits

OSS support from ngrok.com

## Contributing

- Try to follow common patterns
- Always document your PR
