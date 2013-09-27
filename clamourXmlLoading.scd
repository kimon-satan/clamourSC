(


var path = "C:/Users/kimonsatan/code/of_v0.8.0_win_cb_release/apps/interactiveProjects/clamourMedia/bin/data/XMLs/clamourSynths.xml";

~synthDict = ();

d = DOMDocument.new(path);

d.getDocumentElement.getElementsByTagName("SYNTH").do({ arg tag, index;

	var s_name, s_params;

	s_name = tag.getElementsByTagName("NAME");
	s_params = ();


	tag.getElementsByTagName("PARAM").do({arg tag, index;

		var name, min_val, max_val, abs_val, warp, param;

		param = ();

		name = tag.getElementsByTagName("NAME");
		min_val = tag.getElementsByTagName("MIN_VAL");
		max_val = tag.getElementsByTagName("MAX_VAL");
		warp = tag.getElementsByTagName("WARP");

		param.put(\name, name[0].getText.asSymbol);
		param.put(\min_val, min_val[0].getText.asFloat);
		param.put(\max_val, max_val[0].getText.asFloat);
		param.put(\warp, warp[0].getText.asSymbol);
		param.put(\index, index);

		s_params.put(name[0].getText.asSymbol, param);

	});

	~synthDict.put(s_name[0].getText.asSymbol, s_params);

});

)




