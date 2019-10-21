# Disclaimer
This repo is still in beta.  The backend server should work, but there is not a client yet.  The Flutter app is a work in progress.

## Overview
The objective of this repo is to demonstrate the ability to consume a bi-directional communication channel within a Flutter app using gRPC as the communication protocol.  It will also demonstrate an approach for implementing a broadcast backplane within the server implementation.

For this repo, we will build a chat application as features of a chat app require the type of design that the repo intends to demonstrate (i.e., bi-directional communication with broadcast).

## Shout Outs
To jump start the development on the backend service, I opted to leverage an existing Go implemenation rather than roll my own.  I trimmed out a lot of the extra stuff that I didn't need, but the original source was cloned from here: https://github.com/rodaine/grpc-chat

> The aforementioned Go server implementation is much more robust than this one and I recommend you check it out.  It includes boilerplate functionality for login / logout and much more extra swag that here.

I would like to send a special thanks as well to Ishaan Bahal for his article on gRPC in Flutter: https://medium.com/flutter-community/flutter-grpc-810f87612c6d
