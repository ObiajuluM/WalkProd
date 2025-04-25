// filepath: c:\Users\oamba\Desktop\walkit\lib\global\constants.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final kDjangoClientID = dotenv.env['DJANGO_CLIENT_ID'] ?? '';
final kbaseURL = dotenv.env['BASE_URL'] ?? '';
