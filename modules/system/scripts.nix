{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "video-to-dnxhd" 
      (builtins.readFile ../dotfiles/scripts/video-to-dnxhd.sh))
  ];
}
