-- define your colorscheme here
-- local colorscheme = 'monokai_pro'
local colorscheme = 'nightfox' -- carbonfox dawnfox dayfox duskfox nightfox nordfox terafox

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
