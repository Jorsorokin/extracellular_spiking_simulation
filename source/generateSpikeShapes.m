function W = generateSpikeShapes( templates,nUnits,varargin )
    % W = generateSpikeShapes( templates,nUnits,(multiunit) )
    %
    % given a templates structure (from "create_spike_templates")
    % creates a bank of spike waveforms templates, of size 
    % nPts x nSpikes x nChans
    %
    % each generated template W_i is created via: 
    %
    %       W_i = alpha * templates_j / norm( templates_j ) [EQ 1]
    % 
    % for a particular template j. the scaling factor
    % "alpha" is modeled from a gamma distribution fit to the norms of 
    % all templates:
    %
    %   alpha ~ Gamma( a,b ) [EQ 2.1] 
    %
    % If the optional flag "multiunit" is true, alpha is modelled off of a
    % half-normal distribution with variance such that:
    %
    %       P(alpha < min( ||templates|| )) = 0.999 [EQ 2.2]
    %
    % By Jordan Sorokin, 8/4/18
    
    if nargin > 2
        multiunit = varargin{1};
    else
        multiunit = false;
    end
    
    [~,m,c] = size( templates );
    inds = randi( m,1,nUnits );
    
    % get magnitudes of the mean waveforms
    norms = zeros( m,1 );
    templates = concatenateSpikes( templates );
    for k = 1:m
        norms(k) = norm( templates(:,k) );
    end
    
    if ~multiunit
        
        % fit gamma 
        pd = fitdist( norms,'gamma' );
        alpha = gamrnd( pd.a,pd.b,1,nUnits ); % [EQ 2.1]
    else
        
        % fit half normal
        minNorm = min( norms );
        sigma = 0.5;
        x = 0;
        while x < minNorm
            x = norminv( 0.9995,0,sigma ); % added 0.0005 to P to account for half-normal
            sigma = sigma + 0.25;
        end
        
        alpha = abs( randn( 1,nUnits ) * sigma ); % [EQ 2.2]
    end
    
    % scaled copies of the original templates
    W = alpha .* (templates(:,inds) ./ norms(inds)'); % [EQ 1]
    W = expandSpikes( W,c );
    
    % permute the channels in W (so we reduce chances of having very slightly
    % different scalings on the same neuron and channel) 
    for k = 1:nUnits
        nonZero = sum( squeeze( W(:,k,:) ) ) ~= 0;
        ind = min( randi( c ),c-nnz( nonZero ) );
        W(:,k,ind:ind+nnz( nonZero )-1) = W(:,k,nonZero);
        W(:,k,nonZero) = 0;
    end
end