


(

SynthDef(\pulseGlitcher, {|gate = 1, pulseRate = 4, resFilFreq = 1000, resAtt = 0.01, resAmp = 0.2, pan = 0|

	var sig, seed, r_sig, r_env, pulseSpec, resFilSpec;

	seed = LFNoise0.ar(pulseRate);
	r_sig = LFNoise1.ar(2000,10.0);
	r_env = EnvGen.kr(Env.perc(resAtt, 0), seed);
	r_sig = RHPF.ar(r_sig, resFilFreq, 0.01) * r_env * 0.1 * resAmp;

	sig = r_sig + seed;

	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.asr(0.01,1,0.01),gate, doneAction:2);
	Out.ar(0,sig);

}).send(s);


)




