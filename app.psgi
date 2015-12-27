use strict;
use Dancer;

get '/' => sub {
    redirect 'http://dancer.youre.space/'; 
};

dance;
