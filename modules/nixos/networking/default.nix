{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.myModules.networking;
in
{
  imports = [ ./proxy/redsocks.nix ./proxy/dae ];

  options.myModules.networking = {
    enable = mkEnableOption "Enable networking functions";

    proxyWith = mkOption {
      description = "Which program to use for proxying v2ray connection";
      type = types.nullOr (types.enum [ "redsocks" "dae" ]);
      default = null;
    };
  };

  config = mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = "Asia/Jakarta";
    services.ntp.enable = true;
    programs.ssh.startAgent = true;

    networking = {
      networkmanager.enable = true;

      extraHosts =
        ''
          127.0.0.1 mydomain.com
          127.0.0.1 dashboard.mydomain.com
        '';

      firewall = {
        enable = lib.mkDefault true;
        allowedTCPPortRanges = [
          { from = 0; to = 65535; }
        ];
        allowedUDPPortRanges = [
          { from = 0; to = 65535; }
        ];
      };
    };
  };
}
