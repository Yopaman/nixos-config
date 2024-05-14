{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      source = [
        "~/.config/hypr/monitors.conf"
        "~/.config/hypr/mocha.conf"
      ];

      input = {
        kb_layout = "fr";
        kb_variant = "oss";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 2;
        touchpad = {
          natural_scroll = false;
          disable_while_typing = false;
          tap-to-click = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
        "col.active_border" = "$overlay0";
        "col.inactive_border" = "$overlay2";
        layout = "dwindle";
      };

      group = {
        groupbar = {
          "col.active" = "$base";
          "col.inactive" = "$surface1";
        };
      };

      decoration = {
        rounding = 7;

        blur = {
          enabled = true;
          new_optimizations = true;
          passes = 2;
          noise = 0.15;
        };

        drop_shadow = true;
        shadow_range = 15;
        shadow_render_power = 3;
        shadow_offset = "0 3";
        "col.shadow" = "rgba(01010144)";

        dim_inactive = true;
        dim_strength = 0.3;
      };
      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 3, default"
          "borderangle, 1, 3, default"
          "fade, 1, 3, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrule = [
        "size 50% 50% ,float"
        "center,float"
        "float,float"
        "float,customterm"
        "tile,neovide"
        "workspace 7,discord"
        "workspace 6,Spotify"
      ];

      layerrule = [
        "blur, waybar"
        "ignorealpha, waybar"
        "blur, wofi"
        "ignorealpha, wofi"
        "ignorealpha, anyrun"
        "blur, anyrun"
      ];

      "$mainMod" = "SUPER";
      "$mainModShift" = "SUPER_SHIFT";

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [
        "$mainMod, RETURN, exec, alacritty"
        "$mainMod_SHIFT, RETURN, exec, alacritty --class float"
        "$mainMod, Q, killactive,"
        "$mainMod_SHIFT, X, exec, ~/.config/rofi/scripts/powermenu_t2"
        "$mainMod, F, fullscreen,"
        "$mainMod, S, togglefloating,"
        "$mainMod, D, exec, wofi"
        "$mainMod, T, togglegroup,"
        "$mainMod, Y, moveoutofgroup"
        "$mainMod, Tab, changegroupactive,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"


        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"


        "$mainMod_SHIFT, h, swapnext"
        "$mainMod_SHIFT, l, swapnext"

        "$mainMod, ampersand, workspace, 1"
        "$mainMod, eacute, workspace, 2"
        "$mainMod, quotedbl, workspace, 3"
        "$mainMod, apostrophe, workspace, 4"
        "$mainMod, parenleft, workspace, 5"
        "$mainMod, minus, workspace, 6"
        "$mainMod, egrave, workspace, 7"

        "$mainMod_SHIFT, ampersand, movetoworkspace, 1"
        "$mainMod_SHIFT, eacute, movetoworkspace, 2"
        "$mainMod_SHIFT, quotedbl, movetoworkspace, 3"
        "$mainMod_SHIFT, apostrophe, movetoworkspace, 4"
        "$mainMod_SHIFT, parenleft, movetoworkspace, 5"
        "$mainMod_SHIFT, minus, movetoworkspace, 6"
        "$mainMod_SHIFT, egrave, movetoworkspace, 7"


        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ", XF86AudioRaiseVolume, exec, volumectl -u up # pamixer -i 5"
        ", XF86AudioLowerVolume, exec, volumectl -u down # pamixer -d 5"
        ", XF86AudioMute,exec, volumectl toggle-mute # pamixer -t"


        "$mainMod_SHIFT, S, exec, grim -g '$(slurp - d) - | wl-copy'"

        "$mainMod, B, exec, ~/.local/bin/toggle_bar.sh"
        "$mainMod, SEMICOLON, exec, wofi-emoji"


        "$mainMod_SHIFT, space, exec, playerctl -p spotify play-pause"


        "$mainMod_SHIFT, P, exec, hyprpicker -a"
      ];

      exec-once = [
        "~/.config/waybar/launch.sh"
        "hypridle"
        "swww init;swww img ~/.config/hypr/wallpaper.jpeg"
        "nm-applet"
        "swaync"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }

        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };

  home.file.".config/hypr/mocha.conf".source = ./mocha.conf;
  home.file.".config/hypr/wallpaper.jpeg".source = ./wallpaper.jpeg;
  home.file.".config/hypr/wallpaper.png".source = ./wallpaper.png;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
}
