use strict;
use Dancer;

#set serializer => 'mutable';

get '/' => sub {
    template 'index.tt';
};

get '/api/time' => sub {
    headers 'Access-Control-Allow-Origin' => '*';

    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime();
    my $t = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year+1900, $mon+1, $mday, $hour, $min, $sec);
    return { time => $t };
};

get '/api/clientip' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $ip;
    if( $ENV{X_FORWARDED_FOR} ){
      $ip = $ENV{X_FORWARDED_FOR};
    }else{
      $ip = $ENV{REMOTE_ADDR};
    }
    return { clientip => $ip };
};

dance;
