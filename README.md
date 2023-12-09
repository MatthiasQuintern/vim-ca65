# vim-ca6502 Support for the ca65 assembler
This plugin provides syntax highlighting, convenience functions and help pages for the ca65 assembler.
It is focused on the 65C02 processor, please open an issue/a pull request if you find anything that is missing.

By default, the plugin loads for files having a `.s65` or `.h65` extension.
To load it for your preferred extension, write this into `~/.vim/ftdetect/ca6502.vim`:

    " in ~/.vim/ftdetect/ca6502.vim
    au BufRead,BufNewFile *.myExtension setfiletype ca6502


## Syntax
The syntax highlighting currently supports the 65C02 opcodes, the ca65 assembler functions
and the macro packs `generic` and `longbranch`.

If the labels and instructions have the same color in your colorscheme, 
link `ca65Opcode` or `ca65Label` to another class, eg: `hi link ca65Label Typedef`.

## Convenience
This plugin provides the `b:match_words` variable for jumping between words.
Supported are the assembler commands like `.if` `.endif`, `.macro` `.endmacro` as well as stack instructions.
This allows for easier checking of stack push/pull order.


There is also a function that opens a header/source file with the same name in a vsplit.
For example if `~/project/main.s65` is opened, `~/project/main.h65` would be opened.
To use it, map it and set your preferred assembly filetypes.

    " in ~/.vim/ftplugin/ca6502.vim (or vimrc) 
    nnoremap <buffer> <leader>h :call SplitHeader("h65", "s65")<Cr>

## Help
I compiled the datasheet of the WDC 65C02 into a vim help page.
Type `:help <opcode>` to see info about the opcode (addressing modes, updated flags...).
