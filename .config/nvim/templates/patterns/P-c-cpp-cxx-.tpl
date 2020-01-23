exec 'export COMENTARIO="// "'

" for 
inoreabbrev for() for(!cursor!)<cr>{<cr><+++><cr>}<esc>:call IrACursor()<cr>cf!

function! compilar()
	:echom expand('%:p')  
endfunction

