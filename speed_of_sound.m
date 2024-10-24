%speed of sound
function c=speed_of_sound(T_Celsius)
    T_Kelvin=T_Celsius+273.15;
    c=20.1*sqrt(T_Kelvin);
end