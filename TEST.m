function TEST( )
%TEST Summary of this function goes here
%   Detailed explanation goes here
S1='F:\1\4\';
result1=train(S1);
S2='F:\1\7\';
result2=train(S2);
disp('result:')
disp(result1/result2);

end

