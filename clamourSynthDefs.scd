


(

SynthDef(\pulseGlitcher, {|gate = 1, pulseRate = 0.5, resFilFreq = 0.5, resAtt = 0.01, resAmp = 0.5, pan = 0|

	var sig, seed, r_sig, r_env, pulseSpec, resFilSpec;

	pulseSpec = [4,20].asSpec;
	resFilSpec = [100,2000].asSpec;

	seed = LFNoise0.ar(pulseSpec.map(pulseRate));
	r_sig = LFNoise1.ar(2000,10.0);
	r_env = EnvGen.kr(Env.perc(resAtt, 0), seed);
	r_sig = RHPF.ar(r_sig, resFilSpec.map(resFilFreq), 0.01) * r_env * 0.1 * resAmp;

	sig = r_sig + seed;

	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.asr(0.01,1,0.01),gate, doneAction:2);
	Out.ar(0,sig);

}).send(s);


)




