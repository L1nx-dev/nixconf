{ pkgs, system, nix-hug, ... }:


{
  environment.systemPackages = with pkgs; [ 
    # krita
    obs-studio
    blender

    # GAMES #
    prismlauncher
    heroic
    ckan
    lutris

    # SLOP #
    uv
    android-studio-full

    # OTHER #
    bubblewrap
    llama-cpp-rocm
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    libdrm
  ];

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
  #       (pyFinal: pyPrev: {
  #         torchcodec = pyPrev.torchcodec.overridePythonAttrs { doCheck = false; };
  #         torch = pyPrev.torch.override { gpuTargets = [ "gfx1101" ]; };
  #       })
  #     ];
  #   })
  # ];
  #
  # nix.settings.extra-sandbox-paths = [ "/bin/bash=${pkgs.pkgsStatic.bash}/bin/bash" ];
  #
  # nixpkgs.config.rocmSupport = true;

  programs = {
    steam.enable = true;
  };
}
