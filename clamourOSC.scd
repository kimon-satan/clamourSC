//OSC nodes


(



~synthStore = ();

~ini.remove;
~ini=nil;
~ini = OSCresponderNode(nil, '/init', {|i, r, msg|

	msg.postln;

	~synthStore.keysDo({|key|
		~synthStore.at(key).set(\gate, 0);
	});

	fork{
		~masterBus.free;
		s.sync;
		~masterBus = Bus.audio(s, 2);
		~masterOut.free;
		s.sync;
		~masterOut = Synth.new(\master, [\amp, 2, \inBus, ~masterBus]);
	};


}).add;

~killSound.remove;
~killSound=nil;
~killSound = OSCresponderNode(nil, '/killAllSynths',{|i, r, msg|

	msg.postln;

	~synthStore.keysDo({|key|
		~synthStore.at(key).set(\gate, 0);
	});

}).add;

~newSynth.remove;
~newSynth=nil;
~newSynth = OSCresponderNode(nil, '/startSynth', {|i, r, msg|

	var argArray = [\att, msg[4], \dec, msg[5]], fileName;


	msg.postln;


	~synthDict.at(msg[2].asSymbol).do{|item|

		argArray = argArray.add(item.at(\name));
		argArray = argArray.add(msg[item.at(\index) + 6]);


	};

	~synthStore.at(msg[1]).set(\gate, 0); //just incase


	fileName = msg[~synthDict.at(msg[2].asSymbol).size() + 6];
	//find the audio file by name

	if(fileName != "none"){
		fileName.postln;
		argArray.add(\buf);
		argArray.add(~soundFileDict.at(fileName.asSymbol));
	};

	argArray.add(\outBus);
	argArray.add(~masterBus);

	~synthStore.put(msg[1], Synth.new((msg[2] ++ msg[3]).asSymbol, argArray));

}).add;

~updateSynth.remove;
~updateSynth=nil;
~updateSynth = OSCresponderNode(nil, '/updateSynth', {|i, r, msg|


	var argArray = Array.new();
	msg.postln;

	~synthDict.at(msg[2].asSymbol).do{|item|

		argArray = argArray.add([item.at(\name),msg[item.at(\index) + 3]]);

	};

	argArray.do{|item|
		~synthStore.at(msg[1]).set(item[0], item[1]);
	};


}).add;

~stopSynth.remove;
~stopSynth=nil;
~stopSynth = OSCresponderNode(nil, '/stopSynth', {|i, r, msg|

	msg.postln;

	~synthStore.at(msg[1]).set(\gate, 0);
	~synthStore.removeAt(msg[1]);


}).add;


)