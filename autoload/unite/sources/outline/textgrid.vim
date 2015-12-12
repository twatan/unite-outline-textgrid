"=============================================================================
" File: autoload/unite/sources/outline/textgrid.vim
" Author: twatan
" Version: 0.2.0
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
      \ 'heading-1': '"\(IntervalTier\|TextTier\)"$',
      \ 'heading': '^\s*name = \"\(.*\)\"\s*$',
      \}

function! s:outline_info.create_heading(which, heading_line, matched_line, context)
  let heading = {
        \ 'word' : a:heading_line,
        \ 'level': 1,
        \ 'type' : 'generic',
        \ }

  let xmin = a:context.lines[a:context.heading_lnum + 1]
  let xmax = a:context.lines[a:context.heading_lnum + 2]
  let size = a:context.lines[a:context.heading_lnum + 3]

  if a:which ==# 'heading'
    let name = substitute(a:heading_line, '^\s*name = \"\(.*\)\"\s*$', '\1', 'g')
    let xmin = substitute(xmin, '^\s*xmin = \(\S*\)\s*$', '\1', 'g')
    let xmax = substitute(xmax, '^\s*xmax = \(\S*\)\s*$', '\1', 'g')
    let size = substitute(size, '^\s*\(intervals\|points\): size = \(\S*\)\s*$', '\2', 'g')
    let heading.level = 1
  else
    let name = substitute(a:heading_line, '"\(.*\)\"$', '\1', 'g')
    let heading.level = 1
  endif
  let heading.word = join([name, xmin, xmax, size], ', ')
  return heading
endfunction
