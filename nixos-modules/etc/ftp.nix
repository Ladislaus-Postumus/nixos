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

      local_umask=027
    '';
  };

  systemd.tmpfiles.rules = [
    "d /srv 0755 root root - -"
    "d /srv/ftp 0755 root ftpusers - -"
    "d /srv/ftp/scanner 2755 scanner ftpusers - -"
    "d /srv/ftp/scanner/input 2775 paperless paperless - -"
  ];
}
