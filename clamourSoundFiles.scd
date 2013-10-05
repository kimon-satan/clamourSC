
~soundFileDict = ();

(

var fileNames  = [

	"test",
	"aSymbol",
	"butThereIsMore",
	"exactly",
	"forExample",
	"iCanDivide",
	"iCanMake",
	"alternatively",
	"iHaveCreated",
	"iImagine",
	"imInterested",
	"nowLetMe",
	"oneOfYou",
	"orRather",
	"thisPiece",
	"thisPiece2",
	"wellOne",
	"yesThats",
	"youMight",
	"click"

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


