(
x = {|gate = 1 |

	//ideally will be a a gradual build up use just a flat version for now.
	var sig, env;

	sig = Mix.fill( 8,
		{arg count;
			var out, wamp, swell, wobble, freq, pan, flip;

			pan = 0.1 * count * [1,-1].choose;
			freq = 25 + (25 * (count +1));
			swell = LFTri.kr(rrand(0.05,0.1),3,0.25,0.1);
			wobble = SinOsc.kr(rrand(4,14),0,freq/40);
			wamp = SinOsc.kr(0.2 + (0.01 * count),0,0.2,0.3);
			out = VarSaw.ar(freq,0, wamp, swell);
			out = out + RHPF.ar(out, rrand(1000,2000), 0.02, 0.2);
			out = Pan2.ar(out, pan);
		}
	);

	sig = sig * EnvGen.kr(Env.asr(4,1,0.01,'sine'),gate, doneAction:2);



}.play;
)

x.set(\gate, 0)

//using a single synth to build through XML comms

(
x = {|gate = 1, att = 10, dec = 0.01, pan = 0, freq = 25, wmod = 0.2, resamp = 0|

	//ideally will be a a gradual build up use just a flat version for now.
	var sig, env, out, wamp, swell;

	swell = SinOsc.kr(rrand(0.05,0.1),0,0.1,0.25);
	wamp = SinOsc.kr(wmod,0,0.2,0.3);
	sig = VarSaw.ar(freq,0, wamp, swell);
	sig = sig + RHPF.ar(sig, rrand(1000,2000), 0.02, resamp);
	sig = Pan2.ar(sig, pan);



	sig = sig * EnvGen.kr(Env.asr(att,1,dec),gate, doneAction:2);



}.play;
)


