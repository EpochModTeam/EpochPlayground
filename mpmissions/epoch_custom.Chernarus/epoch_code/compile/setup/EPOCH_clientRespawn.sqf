// respawn player

call EPOCH_clientInit;
[] spawn EPOCH_masterLoop;
[5,100] spawn EPOCH_niteLight;
Epoch_canBeRevived = true;


true
