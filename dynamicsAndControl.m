function [x_dot] = dynamicsAndControl (t, x, step, x_d, attitudeFreq, positionFreq) 

	if (mod(step, attitudeFreq) == 0)

end