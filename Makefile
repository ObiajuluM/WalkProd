.PHONY: get clean build run

get:
	flutter pub get

clean:
	flutter clean

	flutter pub get

build:
	flutter clean

	flutter pub get

	flutter build apk

	flutter install apk
	
run:
	flutter run
connect:
	adb connect 192.168.1.210
