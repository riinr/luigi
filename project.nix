{pkgs, extraModulesPath, ...}:
let 
  proto = "${pkgs.xorg.xorgproto}";
  x11   = "${pkgs.xorg.libX11}";
  x11D  = "${pkgs.xorg.libX11.dev}";
in
{
  devshell.name = "luigi";
  packages = [ "nim2" ];

  env = [
    { name = "C_INCLUDE_PATH";  eval = "${proto}/include:${x11D}/include"; }
    { name = "LD_LIBRARY_PATH"; eval = "${x11}/lib"; }
  ];


  # configure direnv .envrc file
  files.direnv.enable = true;

  files.alias.compile = ''
    # nim c --passL:"-L${x11}/lib" $@
    nim c --passL:"-L${x11}/lib" $@
  '';
}
