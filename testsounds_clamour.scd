
//rhythmic glitchy

(
z.free;
z = {

	var sig, seed, r_sig;
	seed = LFNoise0.ar(MouseX.kr(4,20));
	r_sig = EnvGen.kr(Env.perc(MouseY.kr(0,0.1),0.01),seed);
	r_sig = r_sig * 0.5 *  seed * RHPF.ar(LFNoise1.ar(2000,1.0),500,0.01);
	Pan2.ar(r_sig + seed, MouseX.kr(-0.75,0.75));
}.play;
)

//think about something with a sample here
//potentially more varied and better glitch sound






