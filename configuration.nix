# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
  #let 
  #  ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ./path/to/nixpkgs.sh);
  #  home-manager = builtins.fetchTarball {
  #    url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
  #  };
  #in 
  let
#    nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
#    flake-compat = import (builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz");
#    nix-citizen-src = builtins.fetchTarball "https://github.com/LovingMelody/nix-citizen/archive/main.tar.gz";
#    nix-citizen = (flake-compat { src = nix-citizen-src; }).defaultNix;
  in

{
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        <home-manager/nixos> 
      ];
      
  # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelParams = [
	  "initcall_blacklist=simpledrm_platform_driver_init" "mem_sleep_default=deep" "no_console_suspend" ];

security.wrappers.Xorg = {
  setuid = true;
  owner = "root";
  group = "root";
  source = "${pkgs.xorg.xorgserver.out}/bin/Xorg";
};

  # Nix Features
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
  # Environment variables for user sessions
    environment.sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

  # NVIDIA OPTIONS (OpenGl)

    
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [nvidia-vaapi-driver];
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = ["nvidia"];
      

      hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
        # of just the bare essentials.
        powerManagement.enable = true;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of 
        # supported GPUs is at: 
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
        # Only available from driver 515.43.04+
        open = true;

        # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      
  # Home-Mangnger Stuff
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
    home-manager.backupFileExtension = "backup";
    home-manager.users.manolo = import ./home.nix;

    networking.hostName = "nixos"; # Define your hostname.

  # Networking, WLAN and Bluetooth

    networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
    
    networking.interfaces.enp6s0.wakeOnLan.enable = true;

    networking.nameservers = [ "8.8.8.8" ];

    services.openssh = {
    enable = true;
    ports = [ 5432 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
    };

      #    fileSystems."/mnt/synology" = {
      #      device = "//192.168.178.157/Kabul"; 
      #      fsType = "cifs";
      #      options = [
      #        "credentials=/etc/nixos/smb-secrets"
      #        "uid=1000" # Your local user UID
      #        "gid=100"  # Your local user GID
      #        "x-systemd.automount"
      #      ];
      #    };



  # Language and Nationalisation
    # Set your time zone.
    time.timeZone = "Europe/Zurich";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "ch";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "sg";

  # User Acounts
    users.users.manolo = {
      isNormalUser = true;
      description = "manolo";
      extraGroups = [ "uinput" "networkmanager" "wheel" ];
        #      packages = with pkgs; [
        #        # tricks override to fix audio
        #        # see https://github.com/fufexan/nix-gaming/issues/165#issuecomment-2002038453
        #        (nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen.override {
        #          tricks = [ "arial" "vcrun2019" "win10" "sound=alsa" ];
        #        })
        #      ];
    };

    hardware.uinput.enable = true;
users.users.manolo.linger = true;   # keeps PipeWire alive without an active login

  # Virtualisation

    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    users.extraGroups.vboxusers.members = [ "manolo" ];

  # Desktop and Window Managers
    # Hyprland
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    # KDE Plasma
      services.desktopManager.plasma6.enable = true;
      #services.displayManager.sddm = {
      #  enable = true;
      #  wayland.enable = true;
      #};
      services.xserver.displayManager.startx.enable = true;

    services.xserver = {
  enable = true;

  deviceSection = ''
    Option "MetaModes" "1920x1080"
    Option "ConnectedMonitor" "DP-2"
    Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoVertRefreshCheck,NoWidthAlignmentCheck"
    Option "AllowEmptyInitialConfiguration" "True"
  '';

  screenSection = ''
    Option "TwinView" "True"
    DefaultDepth 24
    SubSection "Display"
      Modes "1920x1080"
    EndSubSection
  '';
};

  # Sound
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

  # pkgs

    environment.systemPackages = with pkgs; [
      wget
      vscode
      vim
      vesktop
      spotify-cli-linux
      spotify
      nix-search-tv
      libinput-gestures
      libinput
      kitty
      kdePackages.ktorrent
      kdePackages.kdeconnect-kde
      kdePackages.discover
      kdePackages.dolphin
      google-chrome
      git
      geist-font
      emacsPackages.all-the-icons-nerd-fonts
      fzf
      easyeffects
      direnv
      davinci-resolve-studio
      cudaPackages.cudnn
      cudaPackages.cuda_cudart
      bat
      eww
      mako
      libnotify
      rofi
      waybar
      hyprpolkitagent
      playerctl
      mangohud
      fastfetch
      libreoffice
      filius
      cifs-utils
      s-tui
      itch
      prismlauncher
      jdk17_headless
      gparted
      kdiskmark
      yazi
      w3m
      vlc
      (writeShellScriptBin "ns" (builtins.readFile "${nix-search-tv.src}/nixpkgs.sh"))
      (blender.override { cudaSupport = true; })
    #   nix-citizen.packages.${pkgs.system}.rsi-launcher
    ];

    nixpkgs.config.chromium.commandLineArgs = "
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
      ";

    programs.chromium = {
      enable = true;
    #  homepageLocation = "https://www.startpage.com/";
    #  extensions = [
    #    "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx" # dark reader
    #  ];
    };

    programs.fzf.fuzzyCompletion = true;
    programs.fzf.keybindings = true; 

  # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ]; 
    };
  
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    programs.java.enable = true;
    programs.steam.extraPackages = [ pkgs.jdk ];
    
    
    services.sunshine = {
    enable = true;
      autoStart = false;
      capSysAdmin = false; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
    };

    services.tailscale = {
      enable = true;
    };
  # cacheix
    nix.settings = {
      substituters = ["https://nix-gaming.cachix.org" "https://nix-citizen.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="];
    };
  # Star Citizen
    boot.kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };

    # See RAM, ZRAM & Swap
    swapDevices = [{
      device = "/var/lib/swapfile";
      size = 16 * 1024;  # 8 GB Swap
    }];
    zramSwap = {
      enable = true;
      memoryMax = 16 * 1024 * 1024 * 1024;  # 16 GB ZRAM
    };

    # The following line was used in my setup, but I'm unsure if it is still needed
    # hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
  # Blablabla
    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?

}

