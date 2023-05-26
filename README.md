# Pocketbase Chat Flutter

A Flutter realtime chat app using [pocketbase](https://pocketbase.io/)

## Features

- Login/Signup/Signout
- Remember auth state
- Create Room for chatting
- Realtime chat updates
- Send Text, Image, Voice messages using pocketbase database and storage
- Reply to a message

## Getting Started

Run pocketbase from `pocketbase/pocketbase` folder , its macos executable (you can download for your system from [here](https://pocketbase.io/docs/))

Run pocketbase using ip of your device like : `./pocketbase serve --http "IP_ADDRESS:8090"`

Make sure to update your ipAddress in `lib/app/services/pocketbase_service.dart`

Export `pocketbase/pocket_db_export.json` to pocketbase, this will add few required tables in pocketbase

That's it, run this project, create rooms and chat with friends

## Screenshots



![Screenshot_2023_05_26_17_26_34_47_f2f8d22107bdab5d56c0b6546f71ed9f](https://github.com/rohitsangwan01/flutter_pocketbase_chat/assets/59526499/012be13e-c4f0-471c-a1af-b19b18414a2e)

<img width="799" alt="Screenshot 2023-05-26 at 5 21 00 PM" src="https://github.com/rohitsangwan01/flutter_pocketbase_chat/assets/59526499/437a5406-e990-4dd7-ad65-da08b98dadbf">
![Screenshot_2023_05_26_17_15_49_59_f2f8d22107bdab5d56c0b6546f71ed9f](https://github.com/rohitsangwan01/flutter_pocketbase_chat/assets/59526499/33fa3265-a3de-4332-ade6-dfa94dbc59b2)
![Screenshot_2023_05_26_17_15_24_73_f2f8d22107bdab5d56c0b6546f71ed9f](https://github.com/rohitsangwan01/flutter_pocketbase_chat/assets/59526499/8d300b92-3245-434d-b9d9-de5206be2534)
![Screenshot_2023_05_26_17_14_29_26_f2f8d22107bdab5d56c0b6546f71ed9f](https://github.com/rohitsangwan01/flutter_pocketbase_chat/assets/59526499/2740fc9f-066e-48fd-a4eb-739c0f36823b)
