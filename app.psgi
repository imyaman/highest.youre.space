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
    my $ip = request->address();
    my ($string, $key);
    for $key (keys request->env()){
      $string .= $key . ":" . request->env->{$key} . "    ";
    }
    my $remote_addr = request->env->{'REMOTE_ADDR'};
    my $forwarded = request->env->{'HTTP_X_FORWARDED_FOR'};
    return { clientip => $ip , remote_addr => $remote_addr, forwarded => $forwarded, env => $string };
};

# USAGE
# curl -X POST http://highest.youre.space/api/urldecode -H 'Content-type: application/json' 
#      -d '{"url":"http://highest.youre.space/?q=%EC%95%88%EB%85%95%ED%95%98%EC%84%B8%EC%9A%94"}'
#{
#   "url" : "http://highest.youre.space/?q=안녕하세요"
#}
post '/api/urldecode' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    use Encode;
    my $post = from_json(request->body);
    my $url = urldecode($post->{url});
    $url = decode("UTF-8", $url);
    return { url => $url };
};

sub urldecode {
    my $s = shift;
    $s =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
    $s =~ s/\+/ /g;
    return $s;
}

get '/api/myenv' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($myenv, $key);
    for $key (keys %ENV){
      $myenv .= $key . " : " . $ENV{$key} . "    " ;
    }
    return { myenv => $myenv };
};

get '/api/allenv' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($string, $key);
    for $key (keys request->env()){
      $string .= "\"$key\"" . ":" .  request->env->{$key} . "    ";
    }
    return { $myenv };
};

dance;
