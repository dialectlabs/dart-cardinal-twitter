import 'package:solana/solana.dart';

const CLAIM_REQUEST_SEED = "rent-request";
const ENTRY_SEED = "entry";
const GLOBAL_CONTEXT_SEED = "context";
const GLOBAL_RENTAL_PERCENTAGE = 0.2;
const NAMESPACE_SEED = "namespace";
const nsDelim = ".";
const REVERSE_ENTRY_SEED = "reverse-entry";
const twitterNamespace = "twitter";
const twitterPrefix = "@";
final Ed25519HDPublicKey DEFAULT_PUBKEY =
    Ed25519HDPublicKey.fromBase58("11111111111111111111111111111111");
final Ed25519HDPublicKey NAMESPACES_PROGRAM_ID = Ed25519HDPublicKey.fromBase58(
    "nameXpT2PwZ2iA6DTNYTotTmiMYusBCYqwBLN2QgF4w");
