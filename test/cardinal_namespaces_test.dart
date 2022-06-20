import 'package:cardinal_namespaces/cardinal_namespaces.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/solana.dart';

void main() {
  group('Cardinal twitter service', () {
    const environment = SolanaEnvironment.mainnet;
    print("testing with URL: ${urlMap[environment]}");

    test('test get name fail', () async {
      final displayName =
          await tryGetName(environment, NAMESPACES_PROGRAM_ID, DEFAULT_PUBKEY);
      expect(displayName, equals(null));
    });

    test('test get pubkey from name success', () async {
      const handle = "saydialect";
      final pubKey = Ed25519HDPublicKey.fromBase58(
          "D1ALECTfeCZt9bAbPWtJk7ntv24vDYGPmyS7swp7DY5h");

      final key = await getNameEntry(environment, twitterNamespace, handle);
      expect(key.parsed.data, equals(pubKey));
    });

    test('test get name from pubkey success', () async {
      const handle = "saydialect";
      final pubKey = Ed25519HDPublicKey.fromBase58(
          "D1ALECTfeCZt9bAbPWtJk7ntv24vDYGPmyS7swp7DY5h");

      final displayName =
          await tryGetName(environment, NAMESPACES_PROGRAM_ID, pubKey);
      expect(displayName, equals("@$handle"));
    });
  });
}
