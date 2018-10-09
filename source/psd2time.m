function X = psd2time( psd,varargin )
    % X = psd2time( psd,(nRepeats,plotflag) )
    %
    % generates random time series with the same power spectrum as the
    % provided DOUBLE-SIDED power spectral density psd. 
    %
    % The optional argument "nRepeats" determines how many random series 
    % to generate. Thus, the number of rows in X will be the
    % # of bins in the psd * nRepeats (default = 1)
    %
    % Setting the optional argument "plotflag" to true will result in a
    % figure with the original PSD in black and the psd of the generated
    % time series in red for comparison.
    %
    % If "psd" is a matrix, each column will be processed separately and X
    % will have the same number of columns as "psd"
    %
    % Written by Jordan Sorokin
    
    if nargin > 1 && ~isempty( varargin{1} )
        nRepeats = varargin{1};
    else
        nRepeats = 1;
    end
    
    if nargin > 2 && ~isempty( varargin{2} )
        plotflag = varargin{2};
    else
        plotflag = false;
    end
    
    [n,m] = size( psd );
    nT = n * nRepeats;
    X = zeros( nT,m,class( psd ) );
    
    if isrow( psd )
        psd = psd';
    end
    
    % loop over columns
    for j = 1:m
        for k = 1:nRepeats
            w = randn( n,1 ); % random numbers (white power spectrum) ) [EQ 2]
            a = sqrt( psd(1:n,j) ) .* fft( w ); % sqrt since two sided [EQ 3]
            X((k-1)*n + 1:k*n,j) = real( ifft( a ) ); % [EQ 5]
        end
    end
    
    if plotflag
        figure;
        plot( psd,'k' ); hold on
        plot( abs( fft( X(1:n,:) ) ),'r' );
        set( gca,'tickdir','out','box','off',...
            'xscale','log','yscale','log',...
            'xgrid','on','ygrid','on' );
    end     
end
        
        
    