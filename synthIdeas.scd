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
	|modSpeed = 10, att = 1.0, dec = 2.0, amp = 0.8|
	var sig, freqEnv;
	freqEnv = Line.kr(25,100,att);
	sig = SyncSaw.ar(freqEnv,LFNoise0.kr(modSpeed,200,50),0.2);
	sig = sig * EnvGen.kr(Env.linen(att,1,dec,1,'sine'),doneAction:2);
	sig = Pan2.ar(sig, 0) * amp;

}.play;

)

//zone fire sounds

(

{
	var env = EnvGen.kr(Env.perc(0.5,0.01));

	VarSaw.ar([30, 31],0, env, 0.2) * env;

}.play;


)


//beep

(

{
	var sig;
	sig = SinOsc.ar(1500,0,0.2) * EnvGen.kr(Env.linen(0.01,0.1,0.01),doneAction:2);
	sig = Pan2.ar(sig,0);

}.play;

)

//rumbles etc
(

{
	var sig;
	sig = LFNoise0.ar(100) * EnvGen.kr(Env.linen(0.01,0.5,0.01),doneAction:2);
	sig = LPF.ar(sig, 100);
	sig = Pan2.ar(sig,0);


}.play;

)

//

(

{
	var sig, env;
	env = EnvGen.kr(Env.linen(0.01,1.0,0.01),doneAction:2);
	sig = Pulse.ar(1000,0.1,0.02) * env;

	sig = Pan2.ar(sig,0)

}.play

)

//static
(

{
	var sig, env;
	//env = EnvGen.kr(Env.linen(0.01,0.5,0.01), doneAction:2);
	sig = HPF.ar(WhiteNoise.ar(1),MouseX.kr(10000,50)) * Dust.ar(100);// * env;
	sig = Pan2.ar(sig,0)
}.play;

)


//shit beep
(
{
	var sig, env;
	env = EnvGen.kr(Env.linen(0.01,0.5,0.01), doneAction:2);
	sig = SinOsc.ar(5000,0,5).clip * 0.2 * env;
	sig = Pan2.ar(sig,0)

}.play;
)


(
{
	var sig, env;
	env = EnvGen.kr(Env.linen(0.01,1.0,0.01), doneAction:2);
	sig = Saw.ar(Saw.kr(48,105,200),0.2) * env;
	sig = Pan2.ar(sig,0)

}.play;

)



//fluttery .. not quite right
(

{|freq = 500,  speedModFreq = 4, speedModMul = 5, speedModAdd = 15, rqModFreq = 5|
	var sig, speedMod, rqMod, env;

	rqMod =  SinOsc.kr(1/rqModFreq,0,0.04, 0.05);
	speedMod = SinOsc.kr(1/speedModFreq,0,speedModMul, speedModAdd);
	sig = RLPF.ar(WhiteNoise.ar(0.2), freq, rqMod) * LFPulse.kr(speedMod);
	sig = Pan2.ar(sig, 0);
	env = EnvGen.kr(Env.linen(0.5,10,0.5), doneAction:2);
	sig = sig * env;

}.play;

)








