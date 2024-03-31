# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./nix-alien.nix
    ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Kernel
  boot.kernelPackages = pkgs-unstable.linuxPackages_latest;

  # Boot - SystemD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Networking
  networking.hostName = "phoenix"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Locale
  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Display
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    libinput.enable = false;
    xkb.layout = "us";
    # services.xserver.xkb.options = "eurosign:e,caps:escape";
  };

  # Hardware
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bl
  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # User
  users.users.james = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = true;
    packages = with pkgs; [
      #firefox
      #tree
    ];
  };
  
  users.defaultUserShell = pkgs.fish;

  # System Packages
  environment.systemPackages = with pkgs; [
    binutils
    clang
    fish
    gcc
    git
    glibc
    gnome.gnome-tweaks
    home-manager
    libclang
    nvidia-vaapi-driver
    nvtop
    plocate
    i2c-tools
    vim
  ];
  
  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish bash ];
  
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  
  #nixpkgs.config.permittedInsecurePackages = [
  #  "electron-25.9.0"
  #];

  #home-manager = {
  #  extraSpecialArgs = { inherit inputs; };
  #  users = {
  #    "james" = import ./home.nix;
  #  };
  #};

  # Some programs need SUID wrappers
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
