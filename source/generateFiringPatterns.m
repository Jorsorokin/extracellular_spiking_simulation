function [S,P_fire] = generateFiringPatterns( R,T,dt,tau,varargin )
    % [S,P_fire] = generateFiringPatterns( R,T,dt,tau,(R_ext) )
    %
    % generates a matrix of spike times for artificial neurons, with total
    % # of neurons equal to the # of elements in "fr", the firing rates
    % describing each of the artificial neruons. 
    % 
    % Inputs:
    %   R - an nUnits x 1 vector of baseline firing rates
    %
    %   T - # of samples to simulate
    %
    %   dt - the sampling period (1 / sampling rate)
    %
    %   tau - # of samples for the decay rate of the exponential distribution 
    %         that governs refractory-index firing probabilities as:
    %                   1 - exp( -t / tau )     [EQ 5]
    %   
    %   (R_ext) - external firing rate influence vector of length T.
    %
    % Outputs:
    %   S - spike time matrix of size nUnits x T
    %
    %   P_fire - spike probability matrix of size nUnits x T
    %
    % By Jordan Sorokin, 8/4/18
    
    % create P_ext vector
    nUnits = length( R );
    S = false( nUnits,T );
    P_fire = zeros( nUnits,T );
    P_int = ones( nUnits,1 );
    lastST = zeros( nUnits,1 ) * 1e5; % very long ago
    
    if nargin > 4
        R_ext = varargin{1};
    else
        R_ext = ones( 1,T );
    end

    for t = 1:T
        
        % simulate neural firing for this time point
        [S(:,t),P_fire(:,t)] = generateFiringTime( R,dt,P_int,R_ext(t) ); % [EQ 4]
        
        % update P_int to reflect refractory index
        activeUnit = S(:,t);
        lastST(activeUnit) = t;
        P_int = 1 - exp( -abs( t-lastST ) / tau ); % [EQ 5]
    end
    
    S = sparse( S );
end
        
    