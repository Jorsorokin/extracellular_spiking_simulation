function FR_ext = generateExternalFR( T,eventTimes,envelope )
    % generateExternalFR( T,eventTimes,envelope )
    %
    % creates a 1 x T vector with elements describing the external
    % influence on baseline firing rates.
    
    if any( eventTimes > 0 )
        FR_ext = zeros( 1,T );
        FR_ext( eventTimes ) = 1;
        FR_ext = conv( FR_ext,envelope,'same' ) + 1; % adding 1 makes baseline FR_ext have no effect 
        FR_ext(FR_ext<0) = 0;
    else
        FR_ext = ones( 1,T );
    end
end