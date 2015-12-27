use strict;
use Dancer;

get '/' => sub {
    header 'Location' => 'http://dancer.youre.space/'; 
    pass;
#    template 'index';
};

dance;
