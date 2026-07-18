{ config, lib, pkgs, ... }:

{
    programs.firefox = {
        enable = true;

        policies = {
            # Updates & Background Services
            AppAutoUpdate                 = false;
            BackgroundAppUpdate           = false;

            # Feature Disabling
            DisableFirefoxScreenshots     = true;
            DisableSetDesktopBackground   = true;
            DisablePocket                 = true;
            DisableTelemetry              = true;
            DisableFormHistory            = true;


            # AI
            browser.ai.control.sidebarChatbot = "blocked";

            # UI and Behavior
            DisplayMenuBar                = "never";
            DontCheckDefaultBrowser       = true;
            HardwareAcceleration          = true;
            OfferToSaveLogins             = false;

            # Extensions
            ExtensionSettings = let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
            in {

            "uBlock0@raymondhill.net" = {
                install_url       = moz "ublock-origin";
                installation_mode = "force_installed";
                updates_disabled  = true;
            };


            };

        
        # profiles.default.search = {
            #     force           = true;
            #     default         = "DuckDuckGo";
            #     privateDefault  = "DuckDuckGo";

            #     engines = {
            #     "Nix Packages" = {
            #         urls = [
            #         {
            #             template = "https://search.nixos.org/packages";
            #             params = [
            #             { name = "channel"; value = "unstable"; }
            #             { name = "query";   value = "{searchTerms}"; }
            #             ];
            #         }
            #         ];
            #         icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            #         definedAliases = [ "@np" ];
            #     };

            #     "Nix Options" = {
            #         urls = [
            #         {
            #             template = "https://search.nixos.org/options";
            #             params = [
            #             { name = "channel"; value = "unstable"; }
            #             { name = "query";   value = "{searchTerms}"; }
            #             ];
            #         }
            #         ];
            #         icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            #         definedAliases = [ "@no" ];
            #     };

            #     "NixOS Wiki" = {
            #         urls = [
            #         {
            #             template = "https://wiki.nixos.org/w/index.php";
            #             params = [
            #             { name = "search"; value = "{searchTerms}"; }
            #             ];
            #         }
            #         ];
            #         icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            #         definedAliases = [ "@nw" ];
            #     };
            #     };
        };
    };

}