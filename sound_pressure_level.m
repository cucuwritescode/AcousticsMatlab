%sound pressure level
function spl= sound_pressure_level(P1,P2)
if nargin <2 
    P2=20e-6;
end

spl=20*log10(P1/P2);

end
