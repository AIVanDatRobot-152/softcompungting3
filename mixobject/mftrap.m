function out = mftrap(x,L,C1,C2,R)
if x< L
    out = 0;
elseif x< C1
    out = (x-L)/(C1-L);
elseif x <C2
    out =1;
elseif x< R
    out = (R-x)/(R-C2)
else
    out = 0;
end