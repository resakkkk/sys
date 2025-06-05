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

  # Отключаем X11-сервер (если не нужен)
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

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
    mako
    swaynotificationcenter

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
  
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Разрешить несвободные пакеты
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
