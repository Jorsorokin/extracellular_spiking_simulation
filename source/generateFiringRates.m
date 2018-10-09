function fr = generateFiringRates( estimatedFR,nUnits )
    % fr = generateFiringRates( estimatedFR,nUnits )
    %
    % generates firing rate values for "nUnits" # of neurons by fitting 
    % an exponential distribution to the firing rates contained in the 
    % block object "block" and creating random firing rates using the 
    % fitted exponential distribution (exprnd) as:
    %   
    %       fr ~ lambda* e^(-lambda*x)  [EQ 3], where x is pseudo-random
    %
    % By Jordan Sorokin, 8/4/18
    if isrow( estimatedFR )
        estimatedFR = estimatedFR';
    end
    
    params = fitdist( estimatedFR,'Exponential' );
    fr = exprnd( params.mu,1,nUnits );
end