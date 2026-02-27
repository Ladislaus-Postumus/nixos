{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      Subsystem = "sftp internal-sftp";
    };
    extraConfig = ''
      Match Group sftpusers
        ChrootDirectory /srv/sftp/%u
        ForceCommand internal-sftp
        X11Forwarding no
        AllowTcpForwarding no
    '';
  };

  users.users.sftpuser = {
    isNormalUser = true;
    createHome = false;
    home = "/srv/sftp/sftpuser";
    group = "sftpusers";
  };
  users.groups.sftpusers = { };
}
