//OSC nodes

(

~synthDict = ();

	~ini.remove;
	~ini=nil;
	~ini = OSCresponderNode(nil, '/init', {|i, r, msg|

	msg.postln;

	~synthDict.keysDo({|key|
		~synthDict.at(key).set(\gate, 0);
	});


	}).add;

	~newSynth.remove;
	~newSynth=nil;
	~newSynth = OSCresponderNode(nil, '/startSynth', {|i, r, msg|

	msg.postln;

	~synthDict.put(msg[1], Synth.new(\pulseGlitcher));

	}).add;

	~updateSynth.remove;
	~updateSynth=nil;
	~updateSynth = OSCresponderNode(nil, '/updateSynth', {|i, r, msg|

	msg.postln;
	~synthDict.at(msg[1]).set(\pulseRate, msg[2], \resFilFreq, msg[3], \pan, msg[2]);


	}).add;

	~stopSynth.remove;
	~stopSynth=nil;
	~stopSynth = OSCresponderNode(nil, '/stopSynth', {|i, r, msg|

	msg.postln;

	~synthDict.at(msg[1]).set(\gate, 0);
	~synthDict.removeAt(msg[1]);


	}).add;


)