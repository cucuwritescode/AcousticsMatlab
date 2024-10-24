%sabine formula
function T_r=sabine_formula(V,surface_areas,absorption_coeffs)
if length(surface_areas)~=length(absorption_coeffs)
    error('number of surface areas and absorption coefficients should match')
end
A = sum(surface_areas .* absorption_coeffs); 
    T_r = 0.161 * V / A; %formula de Sabine
end
