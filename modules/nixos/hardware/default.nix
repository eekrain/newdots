{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.myModules.hardware;
in
{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./gpu.nix
    ./suspend-then-hybernate.nix
  ];
  options.myModules.hardware = {
    audio = mkEnableOption "Enable custom audio settings";
    bluetooth = mkEnableOption "Enable custom bluetooth settings";
    gpu = mkOption {
      description = "GPU driver to use";
      type = types.nullOr (types.enum [ "amd" "nvidia" ]);
      default = null;
    };
    suspendThenHybernate = mkEnableOption "Enable suspend-then-hybernate configuration";
  };
}
