use strict;
use Dancer;

get '/' => sub {
    template 'index';
};

#get '/hello' => sub {
#    return $ENV{WORLD} || 'world';
#};
#
#get '/NanumGothicBold.woff' => sub {
#    return $ENV{WORLD} || 'world';
#};
#
#get '/logo' => sub {
#     send_file 'mozilla-marketplace-logo-final.png';
#};

dance;
