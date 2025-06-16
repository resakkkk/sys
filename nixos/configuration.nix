{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = false;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "ru_RU.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Включаем Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Порталы для Wayland

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-wlr
  ];

  # Пользователь
  users.users.mirak = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    wofi
    swww
    waybar
    waypaper
    fish
    xfce.thunar
    firefox
    wineWowPackages.stable
    nwg-look
    fastfetch
    flatpak
    vscode
    git
    ffmpegthumbnailer
    wlogout
    blueman
    nautilus
    killall
    xwayland
    libnotify
    udisks
    gvfs
    neofetch
    gnome-tweaks
    cava
    taterclient-ddnet
    bluez
    bluez-tools
    pipewire
    vimPlugins.lz-n
    cmatrix
    pipes
    tty-clock
    nyancat
    swaynotificationcenter
    grim
    slurp
    pulseaudioFull
    gnome-keyring
    libsecret
    plymouth
    pavucontrol
    winetricks
    rofi-wayland
    rofi-wayland-unwrapped
    rofi
    connman
    appimage-run
    jdk
    jre
    gcc

    #themes

    bibata-cursors
    bibata-cursors-translucent

    arc-theme
    gruvbox-gtk-theme
    materia-theme
    catppuccin-gtk

    papirus-icon-theme
    
  ];

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      liberation_ttf
      fira-code
      roboto
      jetbrains-mono
      mononoki
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" "DejaVu Sans Mono" ];
	sansSerif = [ "Noto Sans" "DejaVu Sans" ];
	serif = [ "Noto Serif" "DejaVu Serif" ];
      };
    };
  };
  
  services.flatpak.enable = true;
  services.tumbler.enable = true;
  programs.fish.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.blueman.enable = true;
  
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        Enable = "source,Sink,Media,Socket";
      };
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    libstdcxx5
    openssl
    alsa-lib
    libGL
    libpulseaudio
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
  ];

  # Разрешить несвободные пакеты
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
