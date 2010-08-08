" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Vim syntax file
" Language:         HSP
" Maintainer:       Gonbei
" Last Modified:    2006/06/01-18:01.
"
" Sorry but I have poor English.
" So the script may contain wrong English expression.
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" prevent duplicate loading
if version < 600
  syntax clear
elseif exists( "b:current_syntax" )
  finish
endif

if version < 508
  command! -nargs=+ HspHiLink hi link <args>
else
  command! -nargs=+ HspHiLink hi def link <args>
endif


" definition of highlight group for hsp
HspHiLink       HspLabel    Label
HspHiLink       HspCtrlFlw  Function
HspHiLink       HspStdMac   Function
HspHiLink       HspSysVal   Constant
HspHiLink       HspAtModule Function
HspHiLink       HspEscChar  SpecialChar
HspHiLink       HspComment  Comment
HspHiLink       HspIfZero   Comment
HspHiLink       HspPreElse  Comment




" ignore case
syn case ignore


" String and character
syn region     String      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=HspEscChar
syn region     String      start=+{"+ skip=+\\\\\|\\"+ end=+"}+ contains=HspEscChar
syn region     Character   display start=+'+ skip=+\\'+ end=+\('\|$\)+ contains=HspEscChar

" Escape character
syn match      HspEscChar   display contained /\\./


" Number
syn match      Number      display /\<0\>/                           " zero
syn match      Number      display /\<[1-9]\d*\.\=\d\{}/             " ten
syn match      Number      display /\<0\o\+\.\=\o\{}/                " oct
syn match      Number      display /\<0\.\d\+/                       " ten, x < 0
syn match      Number      display /\<0x\x\+\.\=\x\{}/               " hex
syn match      Number      display /\<0b[01]\+\.\=[01]\{}/           " bin


" Number ( for Hsp format )
syn match      Number      display /%\d\+/
syn match      Number      display /\$\o\+/

" Boolean ( optional )
if exists( "g:HspUseBoolean" )
  syn keyword     Boolean  true false null
endif

" module identifier
if exists( "g:HspUseAtModule" )
  syn match     HspAtModule    display /[^\*]\(@[a-zA-Z_][a-zA-Z_0-9]*\|@\)/ms=s+1   " @module
endif


" Comment
syn match      HspComment  display /;.*$/                          " comment: ;
syn match      HspComment  display /\/\/.*$/                       " comment: //
syn region     HspComment  start=+\/\*+ end=+\*\/+                 " comment: /* ~ */

" label
syn match      HspLabel    display /\*@\(back\|b\|forward\|f\)\>/

syn match      HspLabel    display /^\s*\*\([a-zA-Z_@][a-zA-Z_0-9]*\|@\)/  " label

" Conditional
syn keyword    Conditional if else return break continue           " conditional

" macro
syn match       Macro       display /^\s*#\s*\(addition\|cfunc\|cmd\|comfunc\|const\|defcfunc\|deffunc\|define\|else\|endif\|enum\|epack\|func\|global\|ifdef\|ifndef\|if\|include\||modfunc\|modinit\|modterm\|modinit\|module\|packopt\|pack\|regcmd\|runtime\|undef\|usecom\|uselib\)/

" #if 0 ~ #endif Comment
syn region      HspIfZero  start=/#if\s\+0/ end=+#endif+ contains=HspIfZero,HspPreElse

" back slash at EOL
syn match       Macro       display /\\\s*$/


" storage class (?)
syn keyword    StorageClass ctype global                           " preproc decoration

" system variable ( and wrapper )
syn keyword		HspSysVal	hspstat hspver cnt err stat 
syn keyword		HspSysVal	mousex mousey mousew strsize refstr 
syn keyword		HspSysVal	looplev sublev iparam wparam lparam 
syn keyword		HspSysVal	hwnd hdc hinstance refdval thismod 
syn keyword		HspSysVal	msgothic msmincho notemax notesize and 
syn keyword		HspSysVal	ginfo_act ginfo_sel ginfo_wx1 ginfo_wy1 ginfo_wx2 ginfo_mx
syn keyword		HspSysVal	ginfo_wy2 ginfo_vx ginfo_vy ginfo_sizex ginfo_sizey ginfo_my
syn keyword		HspSysVal	ginfo_winx ginfo_winy ginfo_mesx ginfo_mesy ginfo_r 
syn keyword		HspSysVal	ginfo_g ginfo_b ginfo_paluse ginfo_dispx ginfo_dispy 
syn keyword		HspSysVal	ginfo_cx ginfo_cy ginfo_intid dir_cur dir_exe 
syn keyword		HspSysVal	dir_win dir_sys dir_cmdline dir_desktop dir_mydoc 

" debug statement
syn keyword     Debug       _debug __hsp30__ __file__ __line__ __date__ __time__ __hspver__


" - - - - Functions ( Order ) - - - - - 
"   - - - - - - - - - - - - - - - - - - -

" standard macro
syn keyword		HspStdMac	while wend until do for
syn keyword		HspStdMac	next switch swend default case 
syn keyword		HspStdMac	swbreak _continue _break foreach oncmd 
syn keyword		HspStdMac	or xor not and

" Control follow
syn keyword		HspCtrlFlw 	end gosub goto 
syn keyword		HspCtrlFlw 	loop onexit repeat
syn keyword		HspCtrlFlw 	onkey onclick onerror exgoto on 


" additional function ( requires to include module )


" hgimg3
syn keyword		Function	fvseti fvset fvadd fvsub fvmul 
syn keyword		Function	fvdiv fvdir fvface fvmin fvmax 
syn keyword		Function	fvouter fvinner fvunit fsin fcos 
syn keyword		Function	fsqr str2fv fv2str str2f f2str 
syn keyword		Function	hgini hgreset hgbye hgdraw hgsync 
syn keyword		Function	hgsetreq hggetreq hgrect hgrotate hgline 
syn keyword		Function	settex texload texload2 loadtoon maketoon 
syn keyword		Function	setfont fprt falpha setsizef setbg 
syn keyword		Function	getbg setmap clscolor clstex clsblur 
syn keyword		Function	texmake texcls texmes texdel setuv 
syn keyword		Function	addspr regobj delobj addplate setcolor 
syn keyword		Function	addbox addmesh addbg setpos setang 
syn keyword		Function	setangr setscale setdir setefx setwork 
syn keyword		Function	addpos addang addangr addscale adddir 
syn keyword		Function	addefx addwork getpos getang getangr 
syn keyword		Function	getscale getdir getefx getwork getposi 
syn keyword		Function	getangi getscalei getdiri getefxi getworki 
syn keyword		Function	selpos selang selscale seldir selefx 
syn keyword		Function	selwork objset1 objsetf1 objadd1 objaddf1 
syn keyword		Function	objmov1 objmovf1 objset1r objmov1r objset2 
syn keyword		Function	objsetf2 objadd2 objaddf2 objmov2 objmovf2 
syn keyword		Function	objset2r objmov2r objset3 objsetf3 objadd3 
syn keyword		Function	objaddf3 objmov3 objmovf3 objset3r objmov3r 
syn keyword		Function	dxfload dxfconv dxfgetpoly modelscale event_wait 
syn keyword		Function	event_jump event_prmset event_prmon event_prmoff event_setpos 
syn keyword		Function	event_setang event_setangr event_setscale event_setdir event_setefx 
syn keyword		Function	event_setwork event_pos event_ang event_angr event_scale 
syn keyword		Function	event_dir event_efx event_work event_addpos event_addang 
syn keyword		Function	event_addangr event_addscale event_adddir event_addefx event_addwork 
syn keyword		Function	setevent delevent newevent cammode settoonedge 
syn keyword		Function	event_uv setobjmode setobjmodel setcoli getcoli 
syn keyword		Function	findobj nextobj event_wpos event_wang event_wscale 
syn keyword		Function	event_wdir event_wefx setborder selmoc selcam 
syn keyword		Function	sellight selcpos selcang selcint sellpos 
syn keyword		Function	sellang sellcolor objgetfv objsetfv objaddfv 
syn keyword		Function	objmovfv objgetv objsetv objgetstr objact 
syn keyword		Function	getanim addxfile addxanim objspeed modelspeed 
syn keyword		Function	hgcapture objlight reglight getxinfo setxinfo 

" hspcmp
syn keyword		Function	hsc_ini hsc_refname hsc_objname hsc_compath hsc_comp 
syn keyword		Function	hsc_getmes hsc_clrmes hsc_ver hsc_bye pack_ini 
syn keyword		Function	pack_view pack_make pack_exe pack_opt pack_rt 
syn keyword		Function	pack_get hsc3_getsym hsc3_messize hsc3_make hsc3_getruntime 
syn keyword		Function	hsc3_run 

" hspda
syn keyword		Function	sortval sortstr sortnote sortget csvstr 
syn keyword		Function	csvnote xnotesel xnoteadd csvsel csvres 
syn keyword		Function	csvflag csvopt csvfind rndf_ini rndf_get 
syn keyword		Function	rndf_geti 

" hhspdb
syn keyword		Function	dbini dbbye dbopen dbclose dbstat 
syn keyword		Function	dbspchr dbsend dbgets 

" hspdx
syn keyword		Function	es_bye es_caps es_palfade es_palset es_boxf 
syn keyword		Function	es_fill es_cls es_fmes es_mes es_put 
syn keyword		Function	es_draw es_window es_area es_opt es_size 
syn keyword		Function	es_pat es_link es_release es_set es_new 
syn keyword		Function	es_get es_find es_check es_offset es_flag 
syn keyword		Function	es_chr es_type es_kill es_clear es_pos 
syn keyword		Function	es_apos es_adir es_ini es_sync es_zoom 
syn keyword		Function	es_copy es_xfer es_buffer es_getbuf es_aim 
syn keyword		Function	es_ang es_timer es_getfps es_screen 

" hspext
syn keyword		Function	aplsel aplobj aplact aplfocus aplstr 
syn keyword		Function	aplkey aplkeyd aplkeyu aplget apledit 
syn keyword		Function	clipset clipsetg clipget comopen comclose 
syn keyword		Function	comput computc comgetc comget gfini 
syn keyword		Function	gfcopy gfdec gfinc fxcopy fxren 
syn keyword		Function	fxinfo fxaget fxaset fxtget fxtset 
syn keyword		Function	selfolder fxshort fxdir fxlink lzdist 
syn keyword		Function	lzcopy emath emstr emcnv emint 
syn keyword		Function	emsin emcos emsqr ematan regkey 
syn keyword		Function	getreg setreg regkill reglist sysexit 
syn keyword		Function	pipeexec pipeget pipeput dirlist2 dirlist2h 
syn keyword		Function	dirlist2r 

" hspinet
syn keyword		Function	netinit netterm netexec netmode neterror 
syn keyword		Function	neturl netrequest netload netfileinfo netdlname 
syn keyword		Function	netproxy netagent netheader netsize filecrc 
syn keyword		Function	filemd5 ftpopen ftpclose ftpresult ftpdir 
syn keyword		Function	ftpdirlist ftpdirlist2 ftpcmd ftprmdir ftpmkdir 
syn keyword		Function	ftpget ftpput ftprename ftpdelete 
syn keyword		Function	sockopen sockclose sockput sockputc sockputb 
syn keyword		Function	sockcheck sockget sockgetc sockgetb sockmake 
syn keyword		Function	sockwait ipget 



" standard function ( do NOT requires to include )
syn keyword		Function	newcom delcom comres querycom comevent 
syn keyword		Function	comevarg sarrayconv 
syn keyword		Function	bcopy chdir delete dirlist exist 
syn keyword		Function	mkdir bload bsave memfile chdpm 
syn keyword		Function	cls mes print title dialog 
syn keyword		Function	bgscr bmpsave boxf buffer chgdisp 
syn keyword		Function	color font gcopy gmode gsel 
syn keyword		Function	gzoom palcolor palette pget picload 
syn keyword		Function	pos pset redraw screen width 
syn keyword		Function	sysfont line circle syscolor hsvcolor 
syn keyword		Function	ginfo grect grotate gsquare objinfo 
syn keyword		Function	axobj winobj sendmsg groll 
syn keyword		Function	alloc dim dimtype poke wpoke 
syn keyword		Function	lpoke sdim ddim memcpy memset 
syn keyword		Function	dup dupptr mref newmod setmod 
syn keyword		Function	delmod memexpand 
syn keyword		Function	mci mmplay mmload mmstop 
syn keyword		Function	button chkbox clrobj combox input 
syn keyword		Function	listbox mesbox objprm objsize objsel 
syn keyword		Function	objmode 
syn keyword		Function	int rnd strlen length length2 
syn keyword		Function	length3 length4 vartype varptr gettime 
syn keyword		Function	str dirinfo double sin cos 
syn keyword		Function	tan atan sqrt sysinfo peek 
syn keyword		Function	wpeek lpeek callfunc absf abs 
syn keyword		Function	logf expf limit limitf varuse 
syn keyword		Function	libptr comevdisp 
syn keyword		Function	getkey mouse randomize stick logmes 
syn keyword		Function	assert mcall 
syn keyword		Function	getstr noteadd notedel noteget noteinfo 
syn keyword		Function	notesel noteunsel strmid instr notesave 
syn keyword		Function	noteload getpath strf cnvwtos cnvstow 
syn keyword     Function    await exec run stop wait

" Type of function's argument 
" I know they are not function. But there are few type's name 
" duplicated by function ( for example int, double, str ... )
" I hesitate to distinguish it and tired. Sorry.
syn keyword     Function    int var str wstr sptr wptr
syn keyword     Function    double label float pval bmscr
syn keyword     Function    comobj prefstr pexinfo nulptr arrray
syn keyword     Function    local array

if exists( "c_minlines" )
  let b:c_minlines = c_minlines
else
  let b:c_minlines = 100
endif
execute "syn sync ccomment HspComment minlines=" . b:c_minlines


delcommand HspHiLink


let b:current_syntax = "hsp"
