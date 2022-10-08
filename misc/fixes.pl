# Label from file path
my $fname=@ARGV[0];
$fname =~ m#src/(.*).md$#;
my $label = $1;
$label = "sec:".$label;
$label =~ y#/#_#;

my @lines;

my $i = 0;
while (<>) {
    $i=$i+1;

    if ($_ !~ /^#+ .*\{#.*\}.*$/) {
        # Top level headers
        s/^# (.*)/# \1 {#$label}/;
        # Make lower level headers something unique
        s/^#(#+) (.*)$/#\1 \2 {#$label$i}/;
    }
    
    # Make relative heml links into section links
    s#\[([^\]]*)\]\(\.{0,2}?/([^)]+)/([^)]+).html\)#\\hyperref[sec:\2_\3]{\1}#g;

    # Try to fix some other internal links
    s#\[([^\]]*)\]\((?!http)[^)]*\#([^)]*)\)#\\hyperref[\2]{\1}#g;

    # environment fix
    s/eqnarray/align/g;

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

    # Gif doesn't play well with latex
    s#!\[Visual\]\(&imgroot&/minkowski.gif\)#[minkowski.gif](https://raw.githubusercontent.com/e-maxx-eng/e-maxx-eng/master/img/minkowski.gif)#;
    
    # Expand image root
    s#&imgroot&#e-maxx-eng/static/img#g;

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

    # amsmath fix
    s/\\over\b/\\youreallyshouldnotuseover/g;

    # try_kuhn hotfix
    s/\\textrm\{try_kuhn\}/\\textrm\{try\\_kuhn\}/g;

    push(@lines, $_);
}

$content = join('',@lines);

# use unnumbered environments (special, match is allowed between lines)
$content =~ s/\$\$[\S\s]?\\begin\{(align|eqnarray)\}/\\begin{\1*}/g;
$content =~ s/\\end\{(align|eqnarray)\}[\S\s]?\$\$/\\end{\1*}/g;

print $content;

print "\n\n";
