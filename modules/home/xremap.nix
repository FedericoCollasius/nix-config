{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  services.xremap = {
    withX11 = true;    # Enable if you use X11/i3
    
    config = {
      modmap = [
        {
          name = "Esc CapsLock swap";
          remap = {
            "CapsLock" = "Esc";
            "Esc" = "CapsLock";
          };
        }
      ];
    };
  };
}
