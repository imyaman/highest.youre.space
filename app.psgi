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

get '/api/myenv' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($myenv, $key);
    for $key (keys %ENV){
      $myenv .= $key . " : " . $ENV{$key} . "    " ;
    }
    return { myenv => $myenv };
};

get '/api/clientip' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $ip;
    if( $ip = $ENV{HTTP_CLIENT_IP} ){ goto HAVEIP; }
    if( $ip = $ENV{HTTP_FORWARDED_FOR} ){ goto HAVEIP; }
    if( $ip = $ENV{HTTP_X_FORWARDED_FOR} ){ goto HAVEIP; }
    if( $ip = $ENV{X_FORWARDED_FOR} ){ goto HAVEIP; }
    if( $ip = $ENV{REMOTE_HOST} ){ goto HAVEIP; }
    if( $ip = $ENV{REMOTE_ADDR} ){ goto HAVEIP; }

HAVEIP:
    return { clientip => $ip };
};

dance;
