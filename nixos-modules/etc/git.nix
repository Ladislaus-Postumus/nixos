{...}: {
  programs.git = {
    enable = true;
    config = [
      {
        user = {
          name = "Philipp Melzer";
          email = "philipp.melzer2014@gmail.com";
        };
      }
      {
        init = {
          defaultBranch = "main";
        };
        push = {
          default = "current";
          forceWithLease = "true";
        };
      }
    ];
  };
}
