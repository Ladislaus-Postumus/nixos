{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 21 ];

  services.vsftpd = {
    enable = true;
    localRoot = "/srv/ftp/scanner/";
    writeEnable = true;
    chrootlocalUser = true;
    allowWriteableChroot = true;
    localUsers = true;
    extraConfig = ''
      listen=YES
      listen_ipv6=NO
    '';
  };
}
