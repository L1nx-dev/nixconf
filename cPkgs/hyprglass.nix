{
  lib,
  mkHyprlandPlugin,
  fetchFromGitHub,
  wf-touch,
  wayland-scanner,
  wayland,
  wayland-protocols,
  nix-update-script,
}:

mkHyprlandPlugin {
  pluginName = "hyprglass";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "hyprnux";
    repo = "hyprglass";
    # rev = "5bc835dcc909cef6980291688143048cf16942b5";
    rev = "v1.1.1";
    hash = "sha256-cQmVmmdaITss2hO6aidKOtq6GtEe85fmgrPcrn1eIUg=";
  };

  nativeBuildInputs = [ wayland-scanner ];

  buildInputs = [
    wf-touch
    wayland
    wayland-protocols
  ];

  dontUseCmakeConfigure = true;

  installPhase = ''
    mkdir -p $out/lib
    install -Dm755 hyprglass.so $out/lib/libhyprglass.so
  '';


  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Hyprland plugin for blur";
    homepage = "https://github.com/hyprnux/hyprglass";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
}
