function [spikeBool,P_fire] = generateFiringTime( fr,dt,P_int,FR_ext )
    % [spikeBool,P_fire] = generateFiringTime( fr,dt,P_int,FR_ext )
    %
    % checks whether or now a particular neuron has firing at the current
    % time point, by also taking into consideration the external (seizure
    % spike) and internal (refractory index) probabilities P_ext and P_int.
    %
    % Firing probabilities are goverend via:
    %       P_fire = fr*dt * FR_ext * P_int  [EQ 4]
    %
    % Written by Jordan Sorokin, 8/4/18
    
    P_fire = max( fr*dt .* P_int .* FR_ext,0 );
    spikeBool = P_fire > rand( size( fr ) );
end