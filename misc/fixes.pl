# Label from file path
$fname=@ARGV[0];
$fname =~ m#src/(.*).md$#;
$label = $1;
$label = "sec:".$label;
$label =~ y#/#_#;

$i = 0;
while (<>) {
    $i=$i+1;

    # Top level headers
    s/^# (.*)/# \1 {#$label}/;
    s#\[([^\]]*)\]\(\.\.?/([^)]+)/([^)]+).html\)#\\hyperref[sec:\2_\3]{\1}#g;

    # Make lower level headers something unique
    s/^#(#+) (.*)/#\1 \2 {#$label$i}/;
    
    # environment fix
    s/eqnarray/align/g;

    # use unnumbered environments
    s/\$\$\\begin\{(align|eqnarray)\}/\\begin{\1*}/g;
    s/\\end\{(align|eqnarray)\}\$\$/\\end{\1*}/g;

    # pandoc is bad with subscripts at times (can we even fix this?)
    s/\\_\\text\{/_\\text\{/g;
    s/\\_\{/_{/g;

    # We don't want overly escaped backslashes
    s/\\\\/\\/g;
    #
    # escape _ in text mode
    s/\\text\{([^}_]*)_([^}_]*)\}/\\text\{\1\\_\2\}/g;

    # Convert url to base name
    #
    #                         <- base->
    #  <- label -><------- url ------->
    s#!\[([^]]*)\]\(([^/)]*/)*([^)]+)\)#![\1](\&imgroot\&/\3)#g;
    
    # Expand image root
    s#&imgroot&#e-maxx-eng/img#g;

    # code fixes
    s! ?<span class="toggle-code">[^<]*</span>!!g;

    # Linebreaks in titles are weird
    s!<br/>! -- !g;

    # code fixes (standardized format, handles caption)
    s/~{3,}/```/g;
    s/^```(cpp|java|python) (.+)/```{caption="\2" .\1}/g;
    s/^```(cpp|java|python)/```{.\1}/g;

    # math fix
    s/\$\\\*\$/\$\*\$/g;

    print;
}
print "\n\n";
