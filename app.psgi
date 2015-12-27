use strict;
use Dancer;

get '/' => sub {
    my $hid=sprintf "%.2d", int(rand 7);
    my $url="http://www" . $hid . ".youre.space/";
    redirect $url; 
};

dance;
