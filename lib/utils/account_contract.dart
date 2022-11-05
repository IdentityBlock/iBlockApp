// should include functions which is available in account contact

import 'dart:io';
import 'package:path/path.dart' show join, dirname;

class AccountContract{

  late final File abiFile;

  AccountContract(){
    abiFile = File(join(dirname(Platform.script.path), 'User.abi.json'));
  }




}