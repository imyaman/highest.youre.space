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
    return { clientip => $ip };
};

any ['get', 'post'] => '/api/base64decode' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    use MIME::Base64;
    use Encode;
    my $data = param 'data';
# my $result = decode("UTF-8", decode_base64($data));
# return { data => $data, result => $result };
# 이유는 모르겠는데, base64 인코딩의 URL을 무언가가 알아서 디코드합니다.
    return { data => $data };
};
# USAGE
# curl http://highest.youre.space/api/base64decode?data=http://highest.youre.space/?data=%EC%95%88%EB%85%95%ED%95%98%EC%84%B8%EC%9A%94%20%EA%B3%BD%EC%83%81%EC%9A%A9%EC%9E%85%EB%8B%88%EB%8B%A4.
#{
#   "data" : "http://highest.youre.space/?data=안녕하세요 곽상용입니다."
#}


get '/api/myenv' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($myenv, $key);
    for $key (keys %ENV){
      $myenv .= $key . " : " . $ENV{$key} . "    " ;
    }
    return { myenv => $myenv };
};

dance;
