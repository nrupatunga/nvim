return {
  {
    "FabijanZulj/blame.nvim",
    event = "BufReadPost",
    config = function()
      require('blame').setup {}
    end,
  },
}
