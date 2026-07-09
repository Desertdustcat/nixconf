{ lib, ... }:

with lib;

# Defining of modules and submodules for rest of Configuration

{
  options.systemnix = {
    hostName = mkOption { # makes an option for config.systemnix.hostName of which the default is "nixos"
      type = types.str;
      default = "nixos";
      description = "How the Machine should be called.";
    };

    machine = mkOption {
      type = types.enum [ 
        "mac" 
        "pc" 
        "t510"
        ];
      default = "pc";
      example = "pc, t510, mac";
      description = "What Hardwarespecific modules should be loaded";
    };

    # Test with bools and submodules
      #   let    # defines varibale boolt
      #     boolt = mkOption { 
      #           type = types.bool;
      #           default = true;
      #           };
      #   in
      #   machine = mkOption {
      #   description = "What Hardwarespecific modules should be loaded";
      #   type = types.submodule { # multiple options
      #       mac = {
      #         intel = boolt;
      #         m = boolt; 
      #       };
      #     };
      # };

  
    DeploymentStyle = mkOption {
      type = types.enum [
        "default"
        "minimal"
      #  "secure" # doesnt acctually do shit
      ];
      default = "default";
      example = "default, minimal, ...";
      description = "How the System should be set up. e.g. what DE, what pkgs.";
    };

    wm = mkOption { 
      type = types.enum [
        "null" # idk if posible
        "kde"
        "hyperland"
        "tty"
        # ...
      ];
      default = "null";
      example = "kde, hyperland, tty, ...";
      description = "What Window Manger should be used.";
    };
  };
}