vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'rrethy/nvim-base16'
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }
  use 'mbbill/undotree'
  
end)
