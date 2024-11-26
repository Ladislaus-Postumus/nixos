# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, security, ... }:

{
  #imports = [
  #  <nixpkgs/nixos/modules/security/ca.nix>
  #];

  environment.variables = {
    # SSL_CERT_FILE = "/home/nixos/certs/inverso_und_vkb.crt";
    # NIX_SSL_CERT_FILE = "/home/nixos/certs/inverso_und_vkb.crt";
    # CURL_CA_BUNDLE = "/home/nixos/certs/inverso_und_vkb.crt";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    CURL_CA_BUNDLE = "/etc/ssl/certs/ca-certificates.crt";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  nix = {
    extraOptions = lib.optionalString (builtins.pathExists "/etc/ssl/self-signed") ''
      trusted-public-keys = /etc/ssl/self-signed/*.crt
      ssl-cert-file = /etc/ssl/self-signed/ca-certificates.crt
    '';

    settings.trusted-users = [ "nixos" ];
  };

  #nix.settings.extraOptions = lib.optionalString (builtins.pathExists "/etc/ssl/self-signed") ''
  #  trusted-public-keys = /etc/ssl/self-signed/*.crt
  #'';
  #security.pki.certifikateFiles = [ "/home/nixos/certs/inverso_und_vkb.crt" ];
}
