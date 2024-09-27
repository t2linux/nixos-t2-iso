{
  stdenvNoCC,
  fetchurl,
  lib,
}:
stdenvNoCC.mkDerivation (final: {
  pname = "get-apple-firmware";
  version = "fe8c338e6cf1238a390984ba06544833ab8792d3";
  src = fetchurl {
    url = "https://raw.github.com/t2linux/wiki/${final.version}/docs/tools/firmware.sh";
    hash = "sha256-DYghvLnG3DO8WmLIrT4p5yzCDWRevp3vx0wYtdTLyeY=";
  };

  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out/bin
    cp ${final.src} $out/bin/get-apple-firmware
    chmod +x $out/bin/get-apple-firmware
  '';

  meta = {
    description = "A script to get needed firmware for T2linux devices";
    homepage = "https://t2linux.org";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ soopyc ];
    mainProgram = "get-apple-firmware";
  };
})
