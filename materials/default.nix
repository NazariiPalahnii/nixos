{pkgs, ...}:
{
  scripts = [
    (pkgs.writeShellScriptBin "sheesh.sh" "pkexec env PATH=$PATH HOME=$HOME DISPLAY=$DISPLAY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_SESSION_TYPE=$XDG_SESSION_TYPE XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR nvim /etc/nixos")
  ];
}
