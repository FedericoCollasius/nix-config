{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/system/scripts.nix
    ];
 
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    
    powerManagement.finegrained = false;

    open = false;
    
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixon";
  
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  networking.networkmanager.enable = true; 

  time.timeZone = "America/Argentina/Buenos_Aires";

  console = {
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    windowManager.i3.enable = true;
    dpi = 100;
  };

   users.users.fede = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
   };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    obsidian
    kitty
    git
    microsoft-edge
    btop
    discord
    spotify
    pavucontrol
    vlc
    telegram-desktop
    gh
    davinci-resolve
    xfce.thunar
    ffmpeg
    tree
    feh
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users = {
      "fede" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;  

  system.stateVersion = "25.05"; 
}
