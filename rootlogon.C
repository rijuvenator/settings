{
	// fixing the window position bug
	gROOT->GetPluginManager()->FindHandler("TBrowserImp", "TRootBrowser");
	gROOT->GetPluginManager()->RemoveHandler("TBrowserImp", "TRootBrowser");
	gROOT->GetPluginManager()->AddHandler("TBrowserImp", "TRootBrowser", "TRootBrowser", "Gui", "NewBrowser(TBrowser *, const char *, Int_t, Int_t, UInt_t, UInt_t, Option_t *)");

	// set style
	//setStyle();
}

void bb()
{
	new TBrowser("Browser","ROOT Object Browser",120,40,1200,750,0,"");
}

TH1F* th(const char* name="h1")
{
	TH1F *h1 = new TH1F(name,"Test;X Axis;Y Axis",100,-10,10);
	h1->FillRandom("gaus",10000);
	return h1;
}

TTree* tt(const char* name, TFile* _file0)
{
		TTree* t = (TTree*) _file0->Get(name);
			return t;
}

void setStyle(int width_=800, int height_=600, int font_=42, float tsize_=0.04)
{
	TStyle *style = new TStyle("style","Style");

	int width = width_;
	int height = height_;
	int font = font_;
	float tMargin = 0.1;
	float lMargin = 0.125;
	float tsize = tsize_;

	float rMargin = tMargin * height / width;
	float bMargin = lMargin;
	float titleX = lMargin + (1-lMargin-rMargin)/2;
	float titleY = 1 - (tMargin/2);

	// generic line thicknesses
	style->SetLineWidth(2);

	// canvas
	style->SetCanvasBorderMode(0);			// off
	style->SetCanvasColor(kWhite);			// white
	style->SetCanvasDefW(width);			// width
	style->SetCanvasDefH(height);			// height

	// pad
	style->SetPadBorderMode(0);				// off
	style->SetPadColor(kWhite);				// white
	style->SetPadGridX(false);				// grid x
	style->SetPadGridY(false);				// grid y
	style->SetGridColor(kGray);				// gray
	style->SetGridStyle(3);					// dotted
	style->SetGridWidth(1);					// pixels

	// pad margins
	style->SetPadTopMargin(tMargin);		// default 0.1
	style->SetPadBottomMargin(bMargin);		// default 0.1
	style->SetPadLeftMargin(lMargin);		// default 0.1
	style->SetPadRightMargin(rMargin);		// default 0.1

	// frame
	style->SetFrameBorderMode(0);			// off
	style->SetFrameFillColor(kWhite);		// white
	style->SetFrameFillStyle(0);			// hollow
	style->SetFrameLineColor(kWhite);		// white
	style->SetFrameLineStyle(1);			// solid
	style->SetFrameLineWidth(0);			// pixels

	// legend
	style->SetLegendBorderSize(0);			// off
	style->SetLegendFont(font);				// helvetica normal

	// hist
	style->SetHistLineColor(kBlack);		// black
	style->SetHistLineStyle(1);				// solid
	style->SetHistLineWidth(2);				// pixels
	style->SetMarkerStyle(kFullDotLarge);	// marker
	style->SetMarkerColor(kBlack);			// black
	style->SetEndErrorSize(0);				// no little lines on errors

	// stats box
	style->SetOptStat(0);					// off

	// title
	style->SetOptTitle(0);					// off
	style->SetTitleFont(font,"");			// helvetica normal
	style->SetTitleTextColor(kBlack);		// black
	style->SetTitleFontSize(tsize+0.02);	// default 0
	style->SetTitleStyle(0);				// hollow
	style->SetTitleFillColor(kWhite);		// white
	style->SetTitleBorderSize(0);			// default 2
	style->SetTitleAlign(22);				// center top
	style->SetTitleX(titleX);				// center title horizontally with respect to frame
	style->SetTitleY(titleY);				// center title vertically within margin

	// axis titles
	style->SetTitleFont(font, "XYZ");		// helvetica normal
	style->SetTitleColor(kBlack, "XYZ");	// black
	style->SetTitleSize(tsize+0.005,"XYZ");	// default 0.02
	style->SetTitleOffset(1,"X");			// default 1
	style->SetTitleOffset(1,"Y");			// default 1

	// axis labels
	style->SetLabelFont(font, "XYZ");		// helvetica normal
	style->SetLabelColor(kBlack, "XYZ");	// black
	style->SetLabelSize(tsize, "XYZ");		// default 0.04
	style->SetLabelOffset(0.005,"XYZ");		// default 0.005

	// axis
	style->SetAxisColor(kBlack, "XYZ");		// black
	style->SetStripDecimals(kTRUE);			// strip decimals
	style->SetPadTickX(1);					// opposite x ticks
	style->SetPadTickY(1);					// opposite y ticks

	style->cd();
}
