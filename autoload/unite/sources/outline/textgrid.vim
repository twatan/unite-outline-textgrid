"=============================================================================
" File: autoload/unite/sources/outline/defaults/textgrid.vim
" Author: twatan
" Version: 0.1.0
"
" Licensed under the MIT license:
" http://www.opensource.org/licenses/mit-license.php
"=============================================================================

function! unite#sources#outline#textgrid#outline_info()
  return s:outline_info
endfunction

"-----------------------------------------------------------------------------
" Outline Info

let s:outline_info = {
      \ 'heading': '^\s*name = \"\(.*\)\"\s*$',
      \ 'heading+1': '^\s*\(intervals\|points\) \[1\]:\s*$',
      \}

function! s:outline_info.create_heading(which, heading_line, matched_line, context)
  let heading = {
        \ 'word' : a:heading_line,
        \ 'level': 1,
        \ 'type' : 'generic',
        \ }

  if a:which ==# 'heading'
    let word = substitute(a:heading_line, '^\s*name = \"\(.*\)\"\s*$', 'Tier: \1', 'g')
    let heading.level = 1
  else
    let word = substitute(a:heading_line, '^\s*\(intervals\|points\): size = \(.*\)$', 'size: \2', 'g')
    let heading.level = 2
  endif
  let heading.word = word
  return heading
endfunction
