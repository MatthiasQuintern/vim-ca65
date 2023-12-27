" Vim syntax file
" Language:	ca65: (MOS 65C02 assembler
" Maintainer: Matthias Quintern
" Latest Revision: December 2023
" Originally by: Oyd E. Leven <oyd11@softhome.net> (2005)

if exists("b:current_syntax")
  finish
endif

if exists("g:ca65_65C02")
  let b:ca65_65C02 = 1
endif
if exists("g:ca65_65816")
  let b:ca65_65816 = 1
endif
if exists("g:ca65_illegal")
  let b:ca65_illegal = 1
endif

" Remove any old syntax stuff hanging about
syn clear
syn case ignore
syntax iskeyword @,48-57,192-255,$,_,.,*

" registers
syn keyword ca65Reg x y a

" ********************************************************************************
" OPCODES
" keywords that are used in regions will not be defined here
" ********************************************************************************
" 65xxx
" ********************************************************************************
syn keyword ca6502Opcode  adc and asl bit brk clc cld cli clv cmp cpx cpy dec dex dey eor inc inx iny lda ldx ldy lsr nop ora pha php pla plp rol ror rti rts sbc sec sed sei sta stx sty tax tay tsx txa txs tya 
syn region  ca6502BranchTarget           matchgroup=ca6502Opcode start="\v(^(.*:)?[ \t]*)@<=(bcc|bcs|beq|bmi|bne|bpl|bvc|bvs|jmp|jsr)[ \t]+" end="$" contains=ca65Comment keepend

" ********************************************************************************
" 6502 - Illegal/undocumented opcodes
" ********************************************************************************
if exists("b:ca65_illegal")
syn keyword ca65Illegal alr anc arr axs dcp isc las lax rla rra sax slo sre
endif

" ********************************************************************************
" 65C02
" ********************************************************************************
if exists("b:ca65_65C02") || exists("b:ca65_65816")
syn keyword ca65C02Opcode   phx phy plx ply stz trb tsb stp wai
syn match   ca65C02Opcode   "bb[rs][0-7]"
syn region  ca65C02BranchTarget     matchgroup=ca65C02Opcode start="\(bra \)" end="$" contains=ca65Comment keepend
syn match   ca65BitSetBranchTarget  "\v(^(.*:)?[ \t]*)@<=(bb[rs][0-7][ \t]+[^,]+,[ \t]*)@<=[^;]+"
endif

" ********************************************************************************
" 65816
" ********************************************************************************
if exists("b:ca65_65816")
syn keyword ca65816Opcode cop mvn mvp pea pei per phb phd phk plb pld rep rtl sep stp tcd tcs tdc tsc txy tyx wai xba xce
syn keyword ca65816OpcodeAlt cpa dea ina swa tad tas tda tsa
syn region  ca65816BranchTarget matchgroup=ca65816Opcode start="\v(^(.*:)?[ \t]*)@<=(brl|jml|jsl)[ \t]+" end="$" contains=ca65Comment keepend
endif

" ********************************************************************************
" ASSEMBLER
" ********************************************************************************
syn match   ca65Label		"\v^\.?[a-z_][a-z0-9_]*:"
syn match   ca65CheapLabel	"^@[a-z_][a-z0-9_]*:"
syn match   ca65UnnamedLabel	"^:"
syn match   ca65Comment		";.*" contains=ca65Todo
syn keyword ca65Todo	    contained todo fixme xxx warning danger note notice bug
syn region  ca65String		start=+"+ skip=+\\"+ end=+"+
syn match   ca65Char		    "'.'"

syn match decNumber	"\<\d\+\>"
syn match hexNumber	"\$\x\+\>" " 'bug', but adding \< doesn't behave!
syn match binNumber	"%[01]\+\>" 
" syn region ca65Immediate start="\v((adc|and|bit|cmp|cpx|cpy|eor|lda|ldx|ldy|ora|sbc) +)@<=#" end="$" contains=ca65Comment,hexNumber,decNumber,binNumber,ca65Char,ca65Expression
syn match ca65Immediate "\v((adc|and|bit|cmp|cpx|cpy|eor|lda|ldx|ldy|ora|sbc|sep|rep)[ \t]+)@<=#"
" ********************************************************************************
" ca65
" ********************************************************************************
syn keyword ca65ControlCommands .a16 .a8 .addr .align .asciiz .assert .autoimport .bankbytes .bss .byt .byte .case .charmap .code .condes .constructor .data .dbyt .debuginfo .define .delmac .delmacro .destructor .dword .else .elseif .end .endenum .endif .endmac .endmacro .endproc .endrep .endrepeat .endscope .endstruct .endunion .enum .error .exitmac .exitmacro .export .exportzp .faraddr .fatal .feature .fileopt .fopt .forceimport .global .globalzp .hibytes .i16 .i8 .if .ifblank .ifconst .ifdef .ifnblank .ifndef .ifnref .ifp02 .ifp4510 .ifp816 .ifpc02 .ifpdtv .ifpsc02 .ifref .import .importzp .incbin .include .interruptor .linecont .list .listbytes .literal .lobytes .local .localchar .macpack .mac .macro .org .out .p02 .p4510 .p816 .pagelen .pagelength .pc02 .pdtv .popcharmap .popcpu .popseg .psc02 .pushcharmap .pushcpu .pushseg .referto .refto .reloc .repeat .res .rodata .scope .segment .set .setcpu .smart .struct .tag .undef .undefine .union .warning .word .zeropage
syn keyword ca65PseudoVariables * .asize .cpu .isize .paramcount .time .version
syn keyword ca65PseudoFunctions .addrsize .bank .bankbyte .blank .concat .const .def,.defined .definedmacro .hibyte .hiword .ident .ismnem,.ismnemonic .left .lobyte .loword .match .max .mid .min .ref,.referenced .right .sizeof .sprintf .strat .string .strlen .tcount .xmatch
syn region  ca65ProcLabel       matchgroup=ca65ControlCommands start="\(\.proc\)" end="$" contains=ca65Comment keepend
" macro packs
syn keyword ca65MacGeneric      add sub
syn region  ca65MacLongbranchTarget       matchgroup=ca65MacLongbranch start="\v(^(.*:)?[ \t]*)@<=(jcc|jcs|jeq|jmi|jne|jpl|jvc)[ \t]+" end="$" contains=ca65Comment keepend
syn region  ca65MacGenericBranchTarget    matchgroup=ca65MacGeneric start="\v(^(.*:)?[ \t]*)@<=(bge|blt|bgt|ble|bnz|bze)[ \t]+" end="$" contains=ca65Comment keepend

" The default methods for highlighting.  Can be overridden later
" LABELS:
hi link ca65CheapLabel	            ca65Label
hi link ca65UnnamedLabel            ca65Label
hi link ca6502BranchTarget          ca65Label
hi link ca65C02BranchTarget	        ca65Label
hi link ca65816BranchTarget	        ca65Label
hi link ca65BitSetBranchTarget	    ca65Label
hi link ca65ProcLabel	            ca65Label
hi link ca65MacLongbranchTarget	    ca65Label
hi link ca65MacGenericBranchTarget  ca65Label
hi link ca65Label	                Label
" TYPES
hi link ca65String	          String
hi link ca65Char	          Character
hi link ca65Comment           Comment
hi link hexNumber             Number
hi link binNumber             Number
hi link decNumber             Number
" ASSEMBLER FUNCTIONS / MACROS
hi link ca65PseudoVariables   PreProc
hi link ca65PseudoFunctions   PreProc
hi link ca65ControlCommands   PreProc
hi link ca65MacLongbranch	  PreProc
hi link ca65MacGeneric	      PreProc
hi link ca65customMacros	  PreProc
" INSTRUCTIONS
hi link ca6502Opcode          ca65Opcode
hi link ca65C02Opcode         ca65Opcode
hi link ca65816Opcode         ca65Opcode
hi link ca65816OpcodeAlt      ca65Opcode
hi link ca65Opcode            Statement
hi link ca65Illegal           Special

hi link ca65Reg               Identifier
hi link ca65Todo              Todo

hi link ca65Immediate         Special
" hi link ca65Expression Special


let b:current_syntax = "ca65"
