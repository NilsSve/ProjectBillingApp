<% Response.ContentType = "text/vnd.wap.wml"%><?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">

<% ' Wml-Sample-5.asp
   '
   ' This sample was created by loading the WML template sample. It contains the basics
   ' of a WML asp file. Most of you WML files will be ASP files, because almost all of your
   ' wml files will be dynamic (think about it, why would you want static wml pages). You use the ASP
   ' page to receive the request. You would typically make calls to your WBO object to perform required
   ' operations (e.g. find row, save data) and to display data (display data from a row, display a report)
   '
   ' Notes on the top two lines.
   '   1. When your wml page has an asp extension, you need to specifically tell the page that it is
   '   a WML page. We do that by setting this content type in the first line.
   '   2. The first two lines MUST appear exactly as as formatted. If any spaces appear in the WML page
   '      before the <?xml...> tag, some phone compilers will generate an error (it's a bug, but it's what
   '      they do).
%>

<% '
   '  Simple Wap Customer list
   '
   ' Initialize Standard Information
   Url = Request.ServerVariables("URL")   ' URL of self, for Posting to self
   RowId=request("RowId")                 ' often passed,
   Randomize:   RID=int(Rnd * 1000)       ' needed for Post bug (not our bug!)
%>

<wml>
<head>
    <meta forua="true" http-equiv="Cache-Control" content="must-revalidate"/>
</head>

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

  <card id="Card1" title="Main" newcontext="true">
    <p>Enter your card text here
      <% ' We added this to make this page do something interested. This was inserted
         ' using the Web Application Integrator (try it). %>
      <% RowId=oWapcustlist.call("get_RunWapCustList",2,RowId)%>
    </p>
  </card>
</wml>






