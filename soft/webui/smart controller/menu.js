function whichBrowser() {
    var BrowserUA = navigator.userAgent;

    if (BrowserUA.indexOf("MSIE") != -1)
        return 1;
    else if (BrowserUA.indexOf("Firefox") != -1)
        return 2;
    else if (BrowserUA.indexOf("Netscape") != -1)
        return 3;
    else if (BrowserUA.indexOf("Chrome") != -1)
        return 4;
    else if (BrowserUA.indexOf("Opera") != -1)
        return 5;
    else if (BrowserUA.indexOf("Safari") != -1)
        return 6;
    else
        return 7;
}

function main_cap(id) {
    var i, j;
    var capclass, CName = "MainTabL";
    tabDiv = document.getElementById(id).childNodes;
    for (i = 0, j = 20; i < 7; i++, j++)
    {
	capclass = CName + j;
        tabDiv[i].childNodes[0].className = capclass;
    }
}

function main_uncap(id) {
    var i, j;
    var uncapclass, CName = "MainTabL";
    tabDiv = document.getElementById(id).childNodes;
    for (i = 0, j = 30; i < 7; i++, j++)
    {
	uncapclass = CName + j + " ShadowText";
        tabDiv[i].childNodes[0].className = uncapclass;
    }
}

function sub_cap(id) {
    var i, j;
    var capclass, CName = "SubTabL";
    tabDiv = document.getElementById(id).childNodes;
    for (i = 0, j = 20; i < 4; i++, j++)
    {
	capclass = CName + j;
	if (j == 23 && whichBrowser() == 1) // Only for IE ... the adjustment of text's position
	    capclass += "IE";
        tabDiv[i].childNodes[0].className = capclass;
    }
}

function sub_uncap(id) {
    var i, j;
    var uncapclass, CName = "SubTabL";
    tabDiv = document.getElementById(id).childNodes;
    for (i = 0, j = 30; i < 4; i++, j++)
    {
	uncapclass = CName + j;
        tabDiv[i].childNodes[0].className = uncapclass;
    }
}
