% room_modes.m
function [frequencies, mode_types] = room_modes(c, L, W, H, max_order)
    frequencies = [];
    mode_types = [];
    for n = 0:max_order
        for p = 0:max_order
            for q = 0:max_order
                if n == 0 && p == 0 && q == 0
                    continue;
                end
                f = room_mode_frequency(c, L, W, H, n, p, q);
                if (n > 0 && p == 0 && q == 0) || (n == 0 && p > 0 && q == 0) || (n == 0 && p == 0 && q > 0)
                    mode_type = 'Axial';
                elseif (n > 0 && p > 0 && q == 0) || (n > 0 && p == 0 && q > 0) || (n == 0 && p > 0 && q > 0)
                    mode_type = 'Tangential';
                else
                    mode_type = 'Oblique';
                end
                frequencies = [frequencies, f];
                mode_types = [mode_types, {mode_type}];
            end
        end
    end
end
