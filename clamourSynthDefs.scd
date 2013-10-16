

(

~masterBus = Bus.audio(s, 2);


SynthDef(\master, {|inBus = 0, outBus = 0 , amp = 1|

	var sig;
	sig = In.ar(~masterBus, 2);
	sig = MulAdd(sig, amp, 0);
	sig = Limiter.ar(sig,0.99,0.01);

	Out.ar(outBus, sig);

}).send(s);

SynthDef(\pulseGlitcherASR, {|gate = 1, att = 0, dec = 0, pulseRate = 4, resFilFreq = 1000, resAtt = 0.01, resAmp = 0.2, pan = 0, amp = 0.2|

	var sig, seed, r_sig, r_env, pulseSpec, resFilSpec;

	seed = LFNoise0.ar(pulseRate);
	r_sig = LFNoise1.ar(2000,10.0);
	r_env = EnvGen.kr(Env.perc(resAtt, 0), seed);
	r_sig = RHPF.ar(r_sig, resFilFreq, 0.01) * r_env * 0.1 * resAmp;

	sig = r_sig + seed * amp;

	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);



SynthDef(\omASR,{|gate = 1, att = 10, dec = 0.01, pan = 0, freq = 25, wmod = 0.2, resamp = 0, amp = 0.2, mute = 0|

	//ideally will be a a gradual build up use just a lat version for now.
	var sig, env, out, wamp, swell;

	swell = SinOsc.kr(rrand(0.05,0.1),0,0.2,0.5);
	wamp = SinOsc.kr(wmod,0,0.2,0.3);
	sig = VarSaw.ar(freq,0, wamp, swell);
	sig = sig + RHPF.ar(sig, rrand(1000,2000), 0.02, resamp);
	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * (1 - EnvGen.kr(Env.asr(0.02,1,0.02),mute));
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);



}).send(s);


SynthDef(\sinAmASR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, am2Pulse = 0.5, am2Mul = 0.5, am2Add = 0.5, amp = 0.2|

	var sig;

	sig = SinOsc.kr(amPulse,0,0.5,0.5);
	sig = LFCub.ar(carFreq,0,1) * sig;
	sig = sig * SinOsc.kr(am2Pulse,0,am2Mul, am2Add);
	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);


}).send(s);

SynthDef(\sinAmAR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, amp = 0.2|

	var sig;

	sig = SinOsc.kr(amPulse,0,0.5,0.5);
	sig = LFCub.ar(carFreq,0,1) * sig;
	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.linen(att,dec/2,dec/2),gate, doneAction:2);
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

SynthDef(\noise0AmAR, {|gate = 1, att = 1.0, dec = 2.0, pan = 0, amPulse = 40, carFreq = 1000, amp = 0.2|

	var sig;

	sig = LFNoise0.kr(amPulse);
	sig = LFCub.ar(carFreq,0,1) * sig;

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.linen(att,dec/2,dec/2),gate, doneAction:2);
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
	pan = 0, rate = 1, amp = 0.5|

	var sig, dur;

	dur = BufDur.kr(buf);
	sig = PlayBuf.ar(1, buf, rate);
	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.linen(att,dur - (att+dec),dec),gate, doneAction:2) * amp;
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef(\monoPlayerASR, {|att = 0.01, dec = 0.01, gate = 1, buf = 1,
	pan = 0, rate = 1, amp = 0.5, loop = 1|

	var sig, dur;

	dur = BufDur.kr(buf);
	sig = PlayBuf.ar(1, buf, rate, loop:1);
	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef(\brownExploderAR,{|att = 0, dec = 0, amp = 0.5, pan = 0|

	var sig;

	sig = BrownNoise.ar(amp);
	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.perc(att,dec),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef(\whiteExploderAR,{|att = 0, dec = 0, amp = 0.5, pan = 0|

	var sig;

	sig = WhiteNoise.ar(amp);
	sig = Pan2.ar(sig, pan);
	sig = sig * EnvGen.kr(Env.perc(att,dec, 1, 4),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef(\sinBeepAR, {|att = 0, dec = 0, amp = 0.5, pan = 0, freq = 1500|

	var sig;
	sig = SinOsc.ar(freq,0,amp);
	sig = Pan2.ar(sig, pan) * EnvGen.kr(Env.linen(0.01,att + dec - 0.02,0.01),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef(\shitBeepAR, {|att = 0, dec = 0, amp = 0.5, pan = 0, freq = 5000, preAmp = 5|

	var sig;
	sig = SinOsc.ar(freq,0,preAmp).clip * 0.5 * amp;
	sig = Pan2.ar(sig, pan) * EnvGen.kr(Env.linen(0.01,att + dec - 0.02,0.01),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef(\rumblerAR, {|att = 0, dec = 0, amp = 0.5, pan = 0, freq = 100, filFreq = 100|

	var sig;
	sig = LFNoise0.ar(freq) * amp;
	sig = LPF.ar(sig, filFreq);
	sig = Pan2.ar(sig,pan)  * EnvGen.kr(Env.linen(0.01,att + dec - 0.02,0.01),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef(\thinBeepAR, {|att = 0, dec = 0, amp = 0.5, pan = 0, freq = 1500, width = 0.1|

	var sig;
	sig = Pulse.ar(freq,width, 0.1) * amp;
	sig = Pan2.ar(sig, pan) * EnvGen.kr(Env.linen(0.01,att + dec - 0.02,0.01),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef(\staticAR, {|att = 0, dec = 0, amp = 0.5, pan = 0, density = 100|

	var sig;
	sig = WhiteNoise.ar(1) * Dust.ar(density) * amp;
	sig = Pan2.ar(sig, pan) * EnvGen.kr(Env.linen(0.01,att + dec - 0.02,0.01),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef.new(\servoAR, {arg trig = 1, att = 0.5, dec = 1.0,  amp = 1,
	start = 0.25, top = 0.5, end = 0, sus = 0.25, filFreq = 0.25, detune = 0.05, pan = 0;

	var sig, env, p_env, a_env, panSpec, freqSpec, filFreqSpec;

	freqSpec = ControlSpec(25,4000,\exp);
	filFreqSpec = ControlSpec(500,5000,\exp);
	panSpec = ControlSpec(-0.75,0.75,\linear);

	env = Env.linen(att,dec* sus, dec * 1-sus,1, 'sine');

	p_env = EnvGen.kr(Env.new([start,top, top, end],[att,dec* sus, dec * 1-sus], [2,'lin',-2]),trig);
	p_env = freqSpec.map(p_env);
	a_env = EnvGen.kr(env,trig, doneAction:2);

	sig = Array.fill(2, {|count| SawDPW.ar(p_env + (count * detune * p_env),0,0.5) * a_env});

	sig = HPF.ar(sig, filFreqSpec.map(filFreq));

	sig = Splay.ar(sig, 0.25, 1, panSpec.map(pan));

	Out.ar(~masterBus,sig);

}).send(s);

SynthDef.new(\servoASR, {arg gate = 1, att = 0.5, dec = 1.0,  amp = 1,
	start = 0.25, top = 0.5, end = 0, sus = 0.25, filFreq = 0.25, detune = 0.05, pan = 0;

	var sig, sig2, env, p_env, p1, p2, a_env, a_env2, panSpec, freqSpec, filFreqSpec;

	freqSpec = ControlSpec(25,4000,\exp);
	filFreqSpec = ControlSpec(500,5000,\exp);
	panSpec = ControlSpec(-0.75,0.75,\linear);

	env = Env.linen(att,dec* sus, dec * 1-sus,1, 'sine');

	p_env = Env.new([start,top, top, end],[att,dec* sus, dec * 1-sus],[2,'lin',-2]);

	p1 = freqSpec.map(EnvGen.kr(p_env, gate));
	p2 = freqSpec.map(EnvGen.kr(p_env, 1-gate));
	a_env = EnvGen.kr(env, gate);
	a_env2 = EnvGen.kr(env, 1- gate, doneAction:2);

	sig = Array.fill(2, {|count| SawDPW.ar(p1 + (count * detune * p1),0,0.5) * a_env});
	sig = HPF.ar(sig, filFreqSpec.map(filFreq));
	sig = Splay.ar(sig, 0.25, 1, panSpec.map(pan));

	sig2 = Array.fill(2, {|count| SawDPW.ar(p2 + (count * detune * p2),0,0.5) * a_env2});
	sig2 = HPF.ar(sig2, filFreqSpec.map(filFreq));
	sig2 = Splay.ar(sig2, 0.25, 1, panSpec.map(pan));

	Out.ar(~masterBus,sig + sig2);

}).send(s);

SynthDef.new(\klankerASR, {arg gate = 1, att = 0.5, dec = 1.0, bFreq = 100, fund = 100, detune = 0.2, amp = 0.5, pan = 0, swellRate = 2, swellMul = 0.25, swellAdd = 0.75;

	var sig, freqs,amps, decs;

	freqs = Array.fill(10,{|c| bFreq + (fund * c) + (Rand(detune, -1 * detune) * fund)});
	amps = Array.fill(10,{1});
	decs = Array.fill(10,{1});

	sig = Klank.ar(`[freqs, amps, decs], BPF.ar(PinkNoise.ar(0.003),500,0.5)) * 6;
	sig = sig * SinOsc.kr(1/swellRate,0,0.25,0.75);

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef.new(\klankerAR, {arg gate = 1, att = 0.5, dec = 1.0, bFreq = 100, fund = 100, detune = 0.2, amp = 0.5, pan = 0;

	var sig, freqs,amps, decs;

	freqs = Array.fill(10,{|c| bFreq + (fund * c) + (Rand(detune, -1 * detune) * fund)});
	amps = Array.fill(10,{1}).normalizeSum();
	decs = Array.fill(10,{1});

	sig = Klank.ar(`[freqs, amps, decs], PinkNoise.ar(0.001));

	sig = Pan2.ar(sig,pan) * amp  * EnvGen.kr(Env.linen(att,dec/2,dec/2),doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);

SynthDef.new(\flutteryASR, {|gate = 1, att = 0.5, dec = 1.0, pan = 0, amp = 0.5, freq = 500,  speedModFreq = 4, speedModMul = 5, speedModAdd = 15, rqModFreq = 5|

	var sig, speedMod, rqMod, env;

	rqMod =  SinOsc.kr(1/rqModFreq,0,0.04, 0.05);
	speedMod = SinOsc.kr(1/speedModFreq,0,speedModMul, speedModAdd);
	sig = RLPF.ar(WhiteNoise.ar(1), freq, rqMod) * LFPulse.kr(speedMod);

	sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef.new(\didgeryASR, {|gate = 1, att = 0.5, dec = 1.0, pan = 0, amp = 0.5, noiseFreq = 100, pulseRate = 10, pulseMul = 0.5, filRate = 2, filMul = 250, filAdd = 1000, rq = 0.2|

	var sig;

	sig = RLPF.ar(LFNoise0.ar(noiseFreq) * LFPulse.ar(pulseRate,pulseMul,1 - pulseMul)
	,SinOsc.kr(1/filRate,0,filMul,filAdd)
	,rq);

sig = Pan2.ar(sig, pan) * amp;
	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);
	Out.ar(~masterBus, sig);

}).send(s);


SynthDef.new(\flyClicheAR, {|gate = 1, att = 0.5, dec = 1.0, lFreq = 200, hFreq = 300, amp = 0.2, pan = 0 |
	var sig;

	sig = Pan2.ar(Gendy1.ar(minfreq: lFreq, maxfreq: hFreq, mul: amp),pan);
	sig = sig * EnvGen.kr(Env.linen(att,0,dec), doneAction: 2);
	Out.ar(~masterBus, sig);

}).send(s);

)



)







