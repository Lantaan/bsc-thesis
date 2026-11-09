# Build the standalone cover from its source directory. Skip rc files to
# prevent the child latexmk process from invoking this configuration again.
system('latexmk', '-norc', '-cd', '-pdf', '-interaction=nonstopmode',
       '-halt-on-error', '-file-line-error', '-outdir=../../build/titlepage',
       'frontmatter/tum-official/Deckblatt.tex') == 0
  or die "Official TUM title-page build failed.\n";

$ENV{'TEXMFVAR'} = 'build/texmf-var';
# Project configuration first, supplied TUM bundle second, TeX defaults last.
my $tex_path_sep = ($^O eq 'MSWin32') ? ';' : ':';
$ENV{'TEXINPUTS'} = '.' . $tex_path_sep . './tum//' . $tex_path_sep
  . ($ENV{'TEXINPUTS'} // '');

$pdf_mode = 4; # LuaLaTeX
$out_dir = 'build';
$aux_dir = 'build';
$interaction = 'nonstopmode';
$synctex = 1;
$file_line_error = 1;
$max_repeat = 5;

# Keep the source tree clean while retaining the finished PDF in build/.
$clean_ext = 'acn acr alg glg glo gls glsdefs ist loa lol run.xml synctex.gz';
