# Office Sports (Android)

Partner project to [Office Sports (iOS)](https://github.com/oyvinddd/officesports).

<img src="https://github.com/konstantpapp/office_sports_android/blob/main/assets/welcome_page.png" width=200px>

## Running on an emulator

1. To run on an emulator you have to add your signing SHA1 to the firebase project. You can find the SHA1 by running the following command in the root folder: `cd android && ./gradlew app:signingReport`

2. Copy the SHA1 from the debug block

3. Go to the firebase project -> project settings -> your apps -> add fingerprint

4. Paste the SHA1 and click save

# office_sports_android
