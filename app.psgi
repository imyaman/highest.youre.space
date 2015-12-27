use strict;
use Dancer;

get '/' => sub {
    $hid=sprintf "%.2d", int(rand 7);
    $url="http://www" . $hid . "youre.space/";
    redirect $url; 
};

dance;
