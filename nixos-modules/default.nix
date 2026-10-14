{lib, ...}: let
  isModule = path:
    lib.hasSuffix ".nix" path
    && path != ./default.nix
    && !(lib.hasInfix "/_" (toString path)); # skip anything under _something/
in {
  imports = lib.filter isModule (lib.filesystem.listFilesRecursive ./.);
}
