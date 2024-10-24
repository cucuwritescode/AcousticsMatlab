%inverse square law
function [I, SIL] = inverse_square_law(W, r, Q)
    % default value for Q if not provided alreadt 
    if nargin < 3
        Q = 1;  % omnidirectional source 
    end
    

    if r == 0
        error('Distance (r) cannot be zero.');
    end
    

    I = (Q * W) / (4 * pi * r^2);
    
    
    I_ref = 1e-12;
   
    SIL = 10 * log10(I / I_ref);
end

