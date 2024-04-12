{ pkgs, config, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      height = 40;
      spacing = 0;
      modules-left = [ "hyprland/window" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "pulseaudio"
        "network"
        "backlight"
        "battery"
        "custom/menu"
        "clock"
        "tray"
      ];
      "hyprland/window" = {
        format = "{initialTitle}";
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
        };
        persistent-workspaces = {
          "*" = 5;
        };
      };
      "pulseaudio" = {
        "format" = "{volume}% {icon}";
        "format-muted" = "{icon}";
        "format-bluetooth" = "{volume}% {icon}";
        "format-bluetooth-muted" = "{icon}";
        "format-icons" = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = [ "" "" "" ];
        };
        "on-click" = "pamixer -t";
      };
      "network" = {
        "format-wifi" = "{essid} ";
        "format-ethernet" = "{ipaddr}/{cidr} 󰈀";
        "tooltip-format" = "{ifname} via {gwaddr} 󰈀";
        "format-linked" = "{ifname} (No IP) 󰈀";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      };
      "backlight" = {
        "format" = "{percent}% {icon}";
        "format-icons" = [ "" ];
      };
      "battery" = {
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        "format-icons" = [ "" "" "" "" "" ];
      };
      "custom/menu" = {
        "interval" = "once";
        "format" = "▼";
        "return-type" = "json";
        "on-click" = "swaync-client -t";
        "tooltip" = false;
      };
      "tray" = {
        "spacing" = 10;
      };
      "clock" = {
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
      };
    }];
  };
  # home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/mocha.css".source = ./mocha.css;
  home.file.".config/waybar/launch.sh" = {
    source = ./launch.sh;
    executable = true;
  };
  home.file.".config/waybar/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
