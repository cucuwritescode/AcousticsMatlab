% room mode frequency
function f = room_mode_frequency(c, L, W, H, n, p, q)
    
    f = (c / 2) * sqrt((n / L)^2 + (p / W)^2 + (q / H)^2);
end
