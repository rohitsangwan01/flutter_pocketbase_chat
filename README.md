# Pocketbase Chat Flutter

A Flutter realtime chat app using [pocketbase](https://pocketbase.io/)

## Features

- Login/Signup
- Remember auth state
- Logout
- Create Room for chatting
- Realtime chat updates
- Send Text,Image,Voice messages using pocketbase storage
- Reply to a message

## Getting Started

Run pocketbase from `pocketbase/pocketbase` folder , its macos executable (you can download for your system from [here](https://pocketbase.io/docs/))

Run pocketbase using ip of your device like : `./pocketbase serve --http "IP_ADDRESS:8090"`

Make sure to update your ipAddress in `lib/app/services/pocketbase_service.dart`

Export `pocketbase/pocket_db_export.json` to pocketbase, this will add few required tables in pocketbase

That's it, run this project, create rooms and chat with friends

## Screenshots

TODO: Add screenshot


