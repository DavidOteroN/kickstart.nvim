-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'lukas-reineke/virt-column.nvim',
    opts = {},
    config = function()
      require('virt-column').setup { virtcolumn = '+1,120' }
    end,
  },
}
