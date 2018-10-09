function [w,fr] = generateMultiUnitNeuron( block )
    % [w,fr] = generateMultiUnitNeuron( block )
    %
    % generates the baseline firing rate and waveform shape of a multi-unit
    % "neuron" from the block object (where neruon.ID == 0)
    %
    % By Jordan Sorokin, 8/5/18
    
    mu = findobj( block.getNeurons(),'ID',0 );
    w = mu(1).meanWaveform;
    fr = sum( [mu(1).nSpikes] ) / sum( [block.getChild( 'Epoch' ).duration] );
end
    