#!/usr/bin/env perl

use strict;
use utf8;
use Encode;
use Dancer;
use POSIX qw(tzset);

binmode STDOUT, ':encoding(UTF-8)';

$ENV{TZ} = 'Asia/Seoul';
tzset();

get '/' => sub {
    template 'index.tt';
};

post '/record' => sub {
  my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime();
  header 'Content-Type' => 'application/json; charset=utf-8';
# return encode_utf8( '{ "version": "0.1.0", "sessionAttributes": {}, "response": { "outputSpeech": { "type": "SimpleSpeech", "values": { "type": "PlainText", "lang": "ko", "value": "You drunk a cup of water at ' . $hour . " " . $min . '. 하하" } }, "card": {}, "directives": [], "shouldEndSession": false } } ' );
#  return '{ "version": "0.1.0", "sessionAttributes": {}, "response": { "outputSpeech": { "type": "SimpleSpeech", "values": { "type": "PlainText", "lang": "ko", "value": "You drunk a cup of water at ' . $hour . " " . $min . '. 하하" } }, "card": {}, "directives": [], "shouldEndSession": false } } ';
  return '{ "version": "0.1.0", "sessionAttributes": {}, "response": { "outputSpeech": { "type": "SimpleSpeech", "values": { "type": "PlainText", "lang": "ko", "value": "잘 하셨습니다. ' . $hour . '시 ' . $min . '분에 물을 마신 것을 기록합니다. 물 드셨으니 주무세요. 세상에서 잠을 제일 빨리 자는 사람 아세요? 이름이 임이, 자입니다." } }, "card": {}, "directives": [], "shouldEndSession": false } } ';
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
    return { clientip => $ip , remote_addr => $remote_addr, forwarded => $forwarded };
};

get '/api/clientiponly' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $forwarded = request->env->{'HTTP_X_FORWARDED_FOR'};
    return { forwarded => $forwarded };
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

my $GOT_READY;
post '/api/md2html' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $post = from_json(request->body);
    my $md = $post->{md};
    my $html = Markdown($md);
    return { html => $html };
};

post '/api/md2html1' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $post = from_json(request->body);
    my $md = $post->{md};
    if($md){
        return { html => $md };
    }else{
        return { html => "error" };
    }
};

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
      $string .= "\"$key\"" . ":" .  request->env->{$key} . "    <br>\n";
    }
    return { $string };
};

get '/api/envinc' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $myinc = join ',,,,', @INC;
    return { $ENV{PWD} => $myinc };
};

dance;
