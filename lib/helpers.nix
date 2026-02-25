{ lib }:
{
  # importAllNixFiles: Loads .nix files from a path with an optional exclude list
  importAllNixFiles = { path, exclude ? [] }:
    if builtins.pathExists path then
      lib.mapAttrsToList (name: type: path + "/${name}") 
        (lib.filterAttrs (name: type: 
          type == "regular" && 
          lib.hasSuffix ".nix" name && 
          name != "default.nix" &&
          # Only keep the file if its full path is NOT in the exclude list
          !(lib.elem (path + "/${name}") exclude)
        ) (builtins.readDir path))
    else [];
}