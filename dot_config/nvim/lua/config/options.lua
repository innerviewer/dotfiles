-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--:mkspell! ~/.config/nvim/spell/fr.utf-8.spl

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.rtp:append("/usr/share/vim/vimfiles")

vim.opt.spelllang = { "en_us", "fr", "ru_ru" }

vim.opt.swapfile = false

vim.opt.langmap = "йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],"
  .. "фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',"
  .. "яz,чx,сc,мv,иb,тn,ьm"
