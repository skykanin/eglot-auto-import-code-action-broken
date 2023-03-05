{ mkDerivation, base, lib }:
mkDerivation {
  pname = "scratch";
  version = "1.0.3";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base ];
  description = "An implementation of the card game Hearts";
  license = lib.licenses.gpl3Plus;
  mainProgram = "scratch";
}
