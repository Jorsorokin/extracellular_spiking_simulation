function envelope = generateEnvelope( L,sigmas,gains )
    % envelope = generateEnvelope( L,sigmas,gains )
    %
    % creates the SWD envelope used to simulate neural firing during
    % seizures. 
    %
    % L = # of points of the envelope
    %
    % sigmas = vector of SDs for gaussians
    % gains = vector of amplitude scaling factors for gaussians 
    %
    % By Jordan Sorokin, 8/5/18
    
    envelope = zeros( L,1 );
    for k = 1:numel( sigmas )
        envelope = envelope + gausswin( L,sigmas(k) )*gains(k);
    end
end