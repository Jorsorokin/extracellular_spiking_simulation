function data = addSpikesToNoise( noise,W,ST )
    % data = addSpikesToNoise( noise,W,ST )
    %
    % adds the voltage waveforms in the nPts x nUnits x nChan matrix "W"
    % to the nChan x T matrix of simulated background "noise" according to
    % the nUnits x T spike time matrix "ST"
    %
    % Written by Jordan Sorokin, 8/5/18
    
    [nPts,nUnits,nChan] = size( W );
    T = size( ST,2 );
    
    assert( nUnits == size( ST,1 ),'ST and W have unequal # of units' );
    assert( T == size( noise,2 ),'ST and noise have unequal lengths' );
    assert( nChan == size( noise,1 ),'W and noise have unequal # of channels' );
    
    data = noise;
    
    % loop over units
    for unit = 1:nUnits
        spikes = find( ST(unit,:) );
        spikes(spikes+nPts > T) = []; % removes those on the edge
        w = squeeze( W(:,unit,:) )';
        for st = spikes
            data(:,st:st+nPts-1) = data(:,st:st+nPts-1) + w;
        end
    end
end