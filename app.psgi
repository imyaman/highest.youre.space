use strict;
use Dancer;

#set serializer => 'mutable';

get '/' => sub {
    template 'index.tt';

#    my $hid=sprintf "%.2d", int(rand 5)+1;
#    my $url="http://www" . $hid . ".youre.space/";
#    redirect $url; 
};

get '/api/time' => sub {
    headers 'Access-Control-Allow-Origin' => '*';

    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime();
    my $t = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year+1900, $mon+1, $mday, $hour, $min, $sec);
    return { time => $t };
};

dance;
