function estimatedFR = estimateFirngRates( block )
    % estimatedFR = estimateFiringRates( block )
    %
    % estimates the firing rates of the neurons in the block object
    % (excluding multi-unit neurons)
    neurons = block.getNeurons();
    bad = [neurons.ID] == 0;
    neurons(bad) = [];
    
    estimatedFR = [neurons.nSpikes] ./ sum( [block.getChild( 'Epoch' ).duration] );
    estimatedFR(estimatedFR < 0.1) = []; % very small firing rates are likely due to noise spikes
end