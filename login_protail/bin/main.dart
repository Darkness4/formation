import 'package:login_protail/login_protail.dart' as login_protail;
import 'package:dscript_exec/dscript_exec.dart';

main(List<String> arguments) async {
  var out = await exec("cmd", ["/c", "type C:\\Windows\\System32\\drivers\\etc\\hosts"]).runGetOutput();
  print(out);
}
