{ lib, stdenv, rustPlatform, fetchFromGitHub, openssl, pkg-config, libiconv, darwin }:

let
  inherit (darwin.apple_sdk.frameworks) Security;
in
rustPlatform.buildRustPackage rec {
  pname = "so";
  version = "0.4.9";

  src = fetchFromGitHub {
    owner = "samtay";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-4IZNOclQj3ZLE6WRddn99CrV8OoyfkRBXnA4oEyMxv8=";
  };

  cargoHash = "sha256-hHXA/n/HQeBaD4QZ2b6Okw66poBRwNTpQWF0qBhLp/o=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [
    libiconv Security
  ];

  meta = with lib; {
  meta = {
    description = "TUI interface to the StackExchange network";
    mainProgram = "so";
    homepage = "https://github.com/samtay/so";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
