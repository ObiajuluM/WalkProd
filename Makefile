ss24:
	adb connect 192.168.1.210

spxl:
	adb connect 192.168.1.176

2pxl:
	adb connect 192.168.53.25

s24_s24:
	adb connect 192.168.53.246

clean:
	flutter clean
	flutter pub get

install:
	flutter clean
	flutter pub get
	flutter build apk
	flutter install apk
