(

var path = "/Users/simonkatan/Documents/SuperCollider/Code/Projects/clamour/clamourSynths.xml";

d = DOMDocument.new(path);

d.getDocumentElement.getElementsByTagName("SYNTH").do({ arg tag, index;

	var name;
	name = tag.getElementsByTagName("NAME");
	name[0].getText.asSymbol.postln;

	tag.getElementsByTagName("PARAM").do({arg tag, index;

		var name, min_val, max_val, abs_val, warp;

		name = tag.getElementsByTagName("NAME");
		min_val = tag.getElementsByTagName("MIN_VAL");
		max_val = tag.getElementsByTagName("MAX_VAL");
		warp = tag.getElementsByTagName("WARP");

		name[0].getText.asSymbol.postln;
		min_val[0].getText.asFloat.postln;
		max_val[0].getText.asFloat.postln;
		warp[0].getText.asSymbol.postln;


	})

});

)