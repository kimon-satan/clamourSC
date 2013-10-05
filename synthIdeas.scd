//basic pulse thingys
(
{
	|amPulse = 40, carFreq = 1000, att = 1.0, dec = 2.0, amp = 0.2|
	var sig, freqEnv;

	amPulse = SinOsc.kr(amPulse,0,0.5,0.5);
	sig = LFCub.ar(carFreq,0,1) * amPulse;
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;


}.play;
)


(
{
	|amPulse = 40, carFreq = 1000, att = 1.0, dec = 2.0, amp = 0.2|
	var sig, freqEnv;

	amPulse = LFPulse.kr(amPulse, width: MouseX.kr(0.1,0.9));
	sig = LFCub.ar(carFreq,0,1) * amPulse;
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;


}.play;
)


(
{
	|amPulse = 20, carFreq = 1000, att = 1.0, dec = 2.0, amp = 0.2|
	var sig, freqEnv;

	amPulse = LFNoise0.kr(amPulse);
	sig = LFCub.ar(carFreq,0,1) * amPulse;
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;


}.play;
)




(
{
	|amPulse = 20, carFreq = 1000, att = 1.0, dec = 2.0, amp = 0.2|
	var sig;

	sig = LFNoise1.kr(amPulse);
	sig = LFCub.ar(carFreq,0,1) * sig;
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;


}.play;
)




(
{
	|amPulse = 20, carFreq = 1000, att = 1.0, dec = 2.0, amp = 0.2|
	var sig, freqEnv;

	sig = Mix.fill(3, {|count|
		var am;
		am = LFNoise0.kr(amPulse);
		LFCub.ar(carFreq * Rand(0.95,1.05),0,1) * am;
	});
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;


}.play;
)


//bit cheesy in this form
(

{
	|modSpeed = 10, att = 1.0, dec = 2.0, amp = 0.2|
	var sig, freqEnv;
	freqEnv = Line.kr(25,100,att);
	sig = SyncSaw.ar(freqEnv,LFNoise0.kr(modSpeed,200,50),0.2);
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;

}.play;

)


