use strict;
use Dancer;

get '/' => sub {
    my $hid=sprintf "%.2d", int(rand 6)+1;
    my $url="http://www" . $hid . ".youre.space/";
    redirect $url; 
};

dance;
