

(

~masterBus = Bus.audio(s, 2);


SynthDef(\master, {|inBus = 0, outBus = 0, amp = 1|

	var sig;
	sig = In.ar(~masterBus, 2);
	sig = MulAdd(sig, amp, 0);
	sig = Limiter.ar(sig,0.99,0.01);

	Out.ar(outBus, sig);

}).send(s);

SynthDef(\pulseGlitcherASR, {|gate = 1, att = 0, dec = 0, pulseRate = 4, resFilFreq = 1000, resAtt = 0.01, resAmp = 0.2, pan = 0, outBus = 0|

	var sig, seed, r_sig, r_env, pulseSpec, resFilSpec;

	seed = LFNoise0.ar(pulseRate);
	r_sig = LFNoise1.ar(2000,10.0);
	r_env = EnvGen.kr(Env.perc(resAtt, 0), seed);
	r_sig = RHPF.ar(r_sig, resFilFreq, 0.01) * r_env * 0.1 * resAmp;

	sig = r_sig + seed;

	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef(\brownExploderAR,{|att = 0, dec = 0, amp = 0.5, pan = 0, outBus = 0|

	var sig;

	sig = BrownNoise.ar(amp);
	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.perc(att,dec),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef(\omASR,{|gate = 1, att = 10, dec = 0.01, pan = 0, freq = 25, wmod = 0.2, resamp = 0, amp = 0.2, outBus = 0|

	//ideally will be a a gradual build up use just a flat version for now.
	var sig, env, out, wamp, swell;

	swell = SinOsc.kr(rrand(0.05,0.1),0,0.2,0.5);
	wamp = SinOsc.kr(wmod,0,0.2,0.3);
	sig = VarSaw.ar(freq,0, wamp, swell);
	sig = sig + RHPF.ar(sig, rrand(1000,2000), 0.02, resamp);
	sig = Pan2.ar(sig, pan) * amp;

	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);



}).send(s);


SynthDef(\sinAmASR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, amp = 0.2|

	var sig;

	sig = SinOsc.kr(amPulse,0,0.5,0.5);
	sig = LFCub.ar(carFreq,0,1) * sig;

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);


}).send(s);

SynthDef(\pulseAmASR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, width = 0.5, amp = 0.2|

	var sig;

	sig = LFPulse.kr(amPulse, width: width);
	sig = LFCub.ar(carFreq,0,1) * sig;

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);


}).send(s);

SynthDef(\noise0AmASR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, amp = 0.2|

	var sig;

	sig = LFNoise0.kr(amPulse);
	sig = LFCub.ar(carFreq,0,1) * sig;

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);


}).send(s);


SynthDef(\noise1AmASR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, amp = 0.2|

	var sig;

	sig = LFNoise1.kr(amPulse);
	sig = LFCub.ar(carFreq,0,1) * sig;

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);


}).send(s);


SynthDef(\monoPlayerAR, {|att = 0.01, dec = 0.01, gate = 1, buf = 1,
	pan = 0, rate = 1, amp = 0.5, outBus = 0|

	var sig, dur;

	dur = BufDur.kr(buf);
	sig = PlayBuf.ar(1, buf, rate);
	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.linen(att,dur - (att+dec),dec),gate, doneAction:2) * amp;
	Out.ar(~masterBus, sig);

}).send(s);


)




