
~soundFileDict = ();

(

var fileNames  = [

	"test",
	"click",
	"clickON",
	"clickOFF",

	//intro files
	"everything",
	"iAgree",
	"iCanDivide",
	"iHaveCreated",
	"iHaveCreated2",
	"iImagine",
	"imInterested",
	"letUsReturn",
	"nowEveryone",
	"soFar",
	"soHereWe",
	"soIveManaged",
	"soWho",
	"thatWasGreat",
	"theConcept",
	"well",
	"youMight",
	"andThis",
	"butWhatUse",
	"aButton"

];

var path = "C:/Users/kimonsatan/Music/projectSamples/clamour/";

~soundFileDict.keysDo({|key|
		~soundFileDict.at(key).free;
	});

~soundFileDict = ();

fileNames.size().do{|count|

	var fileBuf, fp;
	fp = path ++ fileNames[count] ++ ".wav";
	fp.postln;
	fileBuf = Buffer.read(s, fp);
	~soundFileDict.put(fileNames[count].asSymbol, fileBuf);

};


)


