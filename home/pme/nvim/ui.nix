{...}: {
  ui = {
    noice = {
      enable = true;
      setupOpts = {
        lsp = {
          hover.enabled = true;
          signature.enabled = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
        views = {
          hover = {
            border = {style = "rounded";};
            win_options = {
              winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";
              winblend = 0;
            };
          };
        };
      };
    };
    breadcrumbs = {
      enable = true;
      navbuddy.enable = true;
    };
  };
}
