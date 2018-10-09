function ts = generateTimeSeries( X,nRepeats )
    % ts = generateTimeSeries( X,nRepeats )
    %
    % generates a fake time series with equal number of columns as the
    % original matrix X with the same power spectrum as X. The # of rows in
    % "timeSeries" will be the # of rows in X * nRepeats. Further, any
    % correlation structure among the columns of X will be applied to the
    % generated time series
    %
    % By Jordan Sorokin, 8/5/18
    
    % create power spectrum
    F = fft( X );
    P = abs( F ).^2; % double-sided psd ... [EQ 4]
    
    % generate time series
    ts = psd2time( P,nRepeats );
    
    % now re-scale and match covariance
    sigma = diag( std( ts ) );
    U = chol( cov( X ) ); % ... [EQ 7]
    ts = ts/sigma * U; % ... [EQ 6,8]
end
    
    