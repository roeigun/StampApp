public class HttpReqManager {
    
    Public static void reqYahoo(){

    	HttpRequest req = new HttpRequest();
		req.setMethod('POST');
		req.setEndpoint('http://transit.yahoo.co.jp/search/result?flatlon=&from=%E6%97%A5%E6%9C%AC%E6%A9%8B&tlatlon=&to=%E8%91%9B%E8%A5%BF&via=&via=&via=&y=2016&m=08&d=08&hh=13&m2=7&m1=2&type=1&ticket=ic&al=1&shin=1&ex=1&hb=1&lb=1&sr=1&s=0&expkind=1&ws=2&kw=%E8%91%9B%E8%A5%BF');

		String requestString = '';
		req.setBody(requestString);
		//Content-Type: text/xml; charset="utf-8"'
		///req.setHeader('Content-Type','text/json; charset=UTF-8');
		        
		Http h = new Http();
		HTTPResponse res = h.send(req);

		System.debug('------------- ' + res);

    }
   
}