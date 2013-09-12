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


}).add;

~newSynth.remove;
~newSynth=nil;
~newSynth = OSCresponderNode(nil, '/startSynth', {|i, r, msg|

	var argArray = Array.new();
	msg.postln;

	~synthDict.at(msg[2].asSymbol).do{|item|

		argArray = argArray.add(item.at(\name));
		argArray = argArray.add(msg[item.at(\index) + 3]);


	};

	~synthStore.put(msg[1], Synth.new(msg[2].asSymbol, argArray));

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